# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2017-12-15 00:48
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('eventos', '0008_inscripcion_correo'),
    ]

    operations = [
        migrations.AddField(
            model_name='perfiles',
            name='estado',
            field=models.CharField(default=b'ACTIVO', max_length=10),
        ),
    ]
