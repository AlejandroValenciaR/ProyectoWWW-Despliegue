# -*- coding: utf-8 -*-
import os, sys
from django import forms
from captcha.fields import ReCaptchaField


class PagoForm(forms.Form):
    cardnumber = forms.IntegerField()
    expiration = forms.DateField(widget=forms.DateInput(attrs={'type' : "date"}))
    cvcode = forms.IntegerField()
    cardowner = forms.CharField(max_length=50)
    valor = forms.IntegerField()
    cedula = forms.IntegerField()
    robot = ReCaptchaField(error_messages={'required': 'Comprobación de captcha fallida'})