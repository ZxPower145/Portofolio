# Generated by Django 4.1.13 on 2023-12-20 00:48

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('portofolio', '0008_alter_projects_category'),
    ]

    operations = [
        migrations.RenameField(
            model_name='projects',
            old_name='host_link',
            new_name='hostLink',
        ),
        migrations.RenameField(
            model_name='projects',
            old_name='is_active',
            new_name='isActive',
        ),
        migrations.RenameField(
            model_name='projects',
            old_name='is_hosted',
            new_name='isHosted',
        ),
    ]