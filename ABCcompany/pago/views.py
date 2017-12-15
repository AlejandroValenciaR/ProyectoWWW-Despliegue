# -*- coding: utf-8 -*-
from django.template import loader
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.forms.models import model_to_dict
from django.contrib import messages
from pago.forms import *
from pago.models import *
from django.http import JsonResponse


def indexPago(request):
    context = {}
    if request.method == "POST":
        pago = PagoForm(request.POST)

        if pago.is_valid():

            pagoabc = PagoBancoAbc()

            pagoabc.cedula = pago.cleaned_data['cedula']
            pagoabc.valor = pago.cleaned_data['valor']
            pagoabc.cardnumber = pago.cleaned_data['cardnumber']
            pagoabc.cardowner = pago.cleaned_data['cardowner']
            pagoabc.cvcode = pago.cleaned_data['cvcode']
            pagoabc.expiration = pago.cleaned_data['expiration']

            pagoabc.save()

            pago = PagoForm()
            context['form_pago'] = pago
            messages.success(request, "Pago realizado con exito")
            return render(request, 'pago/registro_pago.html', context)
        else:
            messages.error(request, "Error al validar el pago")
            context['form_pago'] = pago
            return render(request, 'pago/registro_pago.html', context)
    else:
        pago = PagoForm()
        context['form_pago'] = pago
        return render(request, 'pago/registro_pago.html', context)

def web_service_consultar_pago(request):
    respuesta = {}
    if request.method == "GET":
        try:
            inscripcion = request.GET['id']
            pago = PagoBancoAbc.objects.get(numeropago=inscripcion)
            respuesta['estado_pago'] = 'PAGADO'
        except Exception as e:
            print (e)
            respuesta['estado_pago'] = 'PENDIENTE'
    else:
        respuesta['estado_pago'] = 'PENDIENTE'

    return JsonResponse(respuesta)