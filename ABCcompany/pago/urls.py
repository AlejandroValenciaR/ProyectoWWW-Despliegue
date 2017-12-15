from django.conf.urls import  url
from django.contrib.auth.views import login
from pago import views

urlpatterns = [
    # ex: /eventos/
    url(r'^$', views.indexPago, name='indexPago'),
    url(r'^consulta$', views.web_service_consultar_pago, name="service_1")
]