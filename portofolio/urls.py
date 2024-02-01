from django.urls import path
from . views import (ProfileView, ProjectsView, ProjectsDetailView, ContactView, ProjectsCategory)

urlpatterns = [
    path('profile/<int:obj_id>', ProfileView.as_view()),
    path('projects/', ProjectsView.as_view()),
    path('projects/category/<slug>', ProjectsCategory.as_view()),
    path('projects/details/<slug:slug>', ProjectsDetailView.as_view()),
    path('contact/', ContactView.as_view()),
]