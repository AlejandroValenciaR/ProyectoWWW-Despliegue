# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2017-12-14 04:04
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='PagoBancoAbc',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cedula', models.BigIntegerField()),
                ('valor', models.BigIntegerField()),
                ('cardnumber', models.BigIntegerField()),
                ('cardowner', models.CharField(max_length=50)),
                ('cvcode', models.BigIntegerField()),
                ('expiration', models.DateField()),
            ],
        ),
    ]
