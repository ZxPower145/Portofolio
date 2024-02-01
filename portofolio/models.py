from django.db import models
from django.contrib.auth.models import User
from PIL import Image
from django.core.files import File
from io import BytesIO
from ckeditor.fields import RichTextField

DOMAIN = 'http://127.0.0.1:8000'


class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    primary_bio = RichTextField(null=True, blank=True)
    secondary_bio = RichTextField(null=True, blank=True)
    has_bio = models.BooleanField(default=False)


class Projects(models.Model):
    CATEGORY_CHOICES = [
        ('GAME', 'GAME'),
        ('WEBSITE', 'WEBSITE'),
        ('APP', 'APP')
    ]

    name = models.CharField(max_length=150, null=True, blank=True)
    category = models.CharField(choices=CATEGORY_CHOICES, max_length=50)
    slug = models.SlugField(unique=True)
    description = RichTextField(null=True, blank=True)
    github = models.CharField(max_length=255, null=True, blank=True)
    hostLink = models.CharField(max_length=255, null=True, blank=True)
    isHosted = models.BooleanField(default=False)
    isActive = models.BooleanField(default=True)
    date_added = models.DateTimeField(auto_now_add=True)
    date_modified = models.DateTimeField(auto_now=True)
    preview = models.ImageField(upload_to='uploads/preview/', blank=True, null=True)
    thumbnail = models.ImageField(upload_to='uploads/thumbnail/', blank=True, null=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Project'
        verbose_name_plural = 'Projects'

    def get_preview(self):
        if self.preview:
            return DOMAIN + self.preview.url
        return ''

    def get_thumbnail(self):
        if self.thumbnail:
            return DOMAIN + self.thumbnail.url
        return ''


class Contact(models.Model):
    name = models.CharField(max_length=150, null=True, blank=True)
    email = models.CharField(max_length=150, null=True, blank=True)
    message = RichTextField(null=True, blank=True)

    def __str__(self):
        return self.name
