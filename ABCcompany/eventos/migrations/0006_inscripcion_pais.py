# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2017-12-14 13:48
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('eventos', '0005_evento_valor_inscripcion'),
    ]

    operations = [
        migrations.AddField(
            model_name='inscripcion',
            name='pais',
            field=models.CharField(default=b'NA', max_length=10),
        ),
    ]
