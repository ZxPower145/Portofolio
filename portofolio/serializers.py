from rest_framework import serializers
from .models import (Profile, Projects, Contact)


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = (
            "id",
            "user",
            "primary_bio",
            "secondary_bio",
            "has_bio"
        )


class ProjectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Projects
        fields = (
            "id",
            "name",
            "category",
            "slug",
            "description",
            "github",
            "hostLink",
            "isHosted",
            "isActive",
            "get_preview",
            "get_thumbnail",
        )


class ContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contact
        fields = (
            "name",
            "email",
            "message",
        )
