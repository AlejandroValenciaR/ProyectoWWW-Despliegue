# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2017-12-14 13:19
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('pago', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='pagobancoabc',
            name='numeropago',
            field=models.BigIntegerField(default=-1),
        ),
    ]
