from django.http import Http404
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import (Profile, Projects, Contact)
import smtplib
from email.message import EmailMessage
from django.conf import settings
from .serializers import (ProfileSerializer, ProjectSerializer, ContactSerializer)


class ProfileView(APIView):
    def get_object(self, obj_id):
        try:
            return Profile.objects.get(id=obj_id)
        except Profile.DoesNotExist:
            raise Http404

    def get(self, request, obj_id, format=None):
        profile = self.get_object(obj_id)
        serializer = ProfileSerializer(profile)
        return Response(serializer.data)


class ProjectsView(APIView):
    def get(self, request, format=None):
        projects = Projects.objects.all()
        serializer = ProjectSerializer(projects, many=True)
        return Response(serializer.data)


class ProjectsDetailView(APIView):
    def get_object(self, slug):
        try:
            return Projects.objects.get(slug=slug)
        except Projects.DoesNotExist:
            raise Http404

    def get(self, request, slug, format=None):
        projects = Projects.objects.get(slug=slug)
        serializer = ProjectSerializer(projects)
        return Response(serializer.data)


class ProjectsCategory(APIView):
    def get_object(self, slug):
        try:
            return Projects.objects.filter(category=slug.upper())
        except Projects.DoesNotExist:
            raise Http404

    def get(self, request, slug, format=None):
        projects = Projects.objects.filter(category=slug.upper())
        for project in projects:
            print(project.description)
        serializer = ProjectSerializer(projects, many=True)
        return Response(serializer.data)


class ContactView(APIView):
    def get(self, request, format=None):
        contacts = Contact.objects.all()
        serializer = ContactSerializer(contacts, many=True)
        return Response(serializer.data)

    def post(self, request):
        data = request.data
        print(data)
        serializer = ContactSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            print('Saved')
            self.send_email(name=data['name'],
                            email=data['email'],
                            message=data['message'],
                            receiver='zxpower@yahoo.com')
            self.send_email(name=data['name'],
                            email=data['email'],
                            message=data['message'])

        else:
            print('Serializer not valid')
        return Response(serializer.data)

    def send_email(self, name, email, message, receiver=None):
        sender = str('zxpower@yahoo.com')
        msg = EmailMessage()
        msg['from'] = sender
        if receiver is not None:
            msg['subject'] = f"Portofolio Message - {name}"
            message_body = f"""
You have a new message from {name}, \n
From the address: {email}, \n
This is the message: \n
"""
            msg['to'] = receiver
        else:
            msg['subject'] = f"Thank you for reaching out {name}"
            message_body = f"""
I will make sure to contact you shortly. \n
Best regards, Costin Bogdan. \n
You have sent the next message: \n
"""
            msg['to'] = email

        msg.set_content(message_body + message)

        try:
            with smtplib.SMTP("smtp.mail.yahoo.com", 587) as server:
                server.starttls()
                server.login(sender, settings.MAIL_PASS)
                server.sendmail(msg['from'], msg['to'], msg.as_string())
                server.quit()
                print('Mail sent successfully')

        except Exception as e:
            print('Ciment')
            print(e)
