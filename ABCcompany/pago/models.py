# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class PagoBancoAbc(models.Model):
    cedula = models.BigIntegerField()
    valor = models.BigIntegerField()
    numeropago = models.BigIntegerField(default=-1)
    cardnumber = models.BigIntegerField()
    cardowner = models.CharField(max_length=50)
    cvcode = models.BigIntegerField()
    expiration = models.DateField()

    def __unicode__(self):
        return self.PagoBancoAbc.cardowner
