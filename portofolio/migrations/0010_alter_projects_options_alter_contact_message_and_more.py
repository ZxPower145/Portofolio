# Generated by Django 4.1.13 on 2024-01-27 22:07

import ckeditor.fields
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('portofolio', '0009_rename_host_link_projects_hostlink_and_more'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='projects',
            options={'verbose_name': 'Project', 'verbose_name_plural': 'Projects'},
        ),
        migrations.AlterField(
            model_name='contact',
            name='message',
            field=ckeditor.fields.RichTextField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='projects',
            name='description',
            field=ckeditor.fields.RichTextField(blank=True, null=True),
        ),
    ]