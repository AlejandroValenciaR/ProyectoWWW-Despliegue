# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2017-12-14 21:23
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('eventos', '0007_inscripcion_sexo'),
    ]

    operations = [
        migrations.AddField(
            model_name='inscripcion',
            name='correo',
            field=models.EmailField(default=b'Sin email', max_length=254),
        ),
    ]