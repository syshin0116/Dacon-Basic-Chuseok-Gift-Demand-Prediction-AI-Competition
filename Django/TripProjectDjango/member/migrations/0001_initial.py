# Generated by Django 4.0.4 on 2022-05-26 01:27

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Member',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('member_idx', models.CharField(max_length=100)),
                ('member_id', models.CharField(max_length=100)),
                ('member_pw', models.CharField(max_length=100)),
                ('member_name', models.CharField(max_length=100)),
                ('member_birth', models.DateTimeField()),
                ('member_addr', models.CharField(max_length=100)),
                ('member_gender', models.IntegerField()),
                ('member_naver_token', models.CharField(max_length=100)),
                ('member_google_token', models.CharField(max_length=100)),
            ],
        ),
    ]