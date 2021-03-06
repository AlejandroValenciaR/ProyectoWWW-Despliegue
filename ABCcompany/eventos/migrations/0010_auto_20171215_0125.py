# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2017-12-15 01:25
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('eventos', '0009_perfiles_estado'),
    ]

    operations = [
        migrations.AddField(
            model_name='actividad',
            name='dia_actividad',
            field=models.IntegerField(default=1),
        ),
        migrations.AlterField(
            model_name='actividad',
            name='descripcion',
            field=models.CharField(max_length=5000),
        ),
        migrations.AlterField(
            model_name='actividad',
            name='estado',
            field=models.CharField(default=b'ACTIVA', max_length=10),
        ),
    ]
