import 'package:local_people_core/profile.dart';
import 'package:intl/intl.dart';

var today = DateTime.now();
var tomorrow = today.add(const Duration(days: 1));
var tokenExpirationDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'").format(tomorrow);
List<ClientProfile> testClientProfiles = [
  ClientProfile(
    fullName: 'Ruel Sison',
    email: 'rsjudge17@gmail.com',
    token: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ii0zMndiMC15aEQ1U2FyM01CTm82QyJ9.eyJpc3MiOiJodHRwczovL2NvbWJpbmVkb3RhaS5ldS5hdXRoMC5jb20vIiwic3ViIjoiVFNPY0MxaWZjdWdRejZOYXNjc29iZ3YxeVkxUXR0TFlAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxwZW9wbGUtYXBpIiwiaWF0IjoxNjE5NzcwMTc3LCJleHAiOjE2MTk4NTY1NzcsImF6cCI6IlRTT2NDMWlmY3VnUXo2TmFzY3NvYmd2MXlZMVF0dExZIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.lk1We2ISICepnLwYMWZd-rA3e05A6cr_jd2LyTiZTzBIQWT82LJyEYArRKW_AsGxWnGBusjZQD_4_8IZIBBaGI09y5l1GNt6tkQWNsfE2F2ujSuIiuw9w8_jPquNHp_j1o6gG6AQmtEUffQ-C9xOaHYu4VM7Hc-AX09h5YXk1CtTgAj87IRjyC6yAvkTc6I59lRUGj5osJybvHUlX8oqh5uFz2uwrSh4E7621-eCYZB_sO5FNxHSZq-hlUuigIwkWO6G3EP8vl3ZUntve6doNjE8xgSiwBPwHZnsydfyfQmyquk613E-d-Aaw37KAw-Zs9Gc7G6y754Rq-AwyTi7YQ"',
    tokenExpirationDate: tokenExpirationDate,
    intro: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'
  ),
  ClientProfile(
    fullName: 'Client Name',
    email: 'rsjudge18@gmail.com',
    token: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ii0zMndiMC15aEQ1U2FyM01CTm82QyJ9.eyJpc3MiOiJodHRwczovL2NvbWJpbmVkb3RhaS5ldS5hdXRoMC5jb20vIiwic3ViIjoiVFNPY0MxaWZjdWdRejZOYXNjc29iZ3YxeVkxUXR0TFlAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxwZW9wbGUtYXBpIiwiaWF0IjoxNjE5NzcwMTc3LCJleHAiOjE2MTk4NTY1NzcsImF6cCI6IlRTT2NDMWlmY3VnUXo2TmFzY3NvYmd2MXlZMVF0dExZIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.lk1We2ISICepnLwYMWZd-rA3e05A6cr_jd2LyTiZTzBIQWT82LJyEYArRKW_AsGxWnGBusjZQD_4_8IZIBBaGI09y5l1GNt6tkQWNsfE2F2ujSuIiuw9w8_jPquNHp_j1o6gG6AQmtEUffQ-C9xOaHYu4VM7Hc-AX09h5YXk1CtTgAj87IRjyC6yAvkTc6I59lRUGj5osJybvHUlX8oqh5uFz2uwrSh4E7621-eCYZB_sO5FNxHSZq-hlUuigIwkWO6G3EP8vl3ZUntve6doNjE8xgSiwBPwHZnsydfyfQmyquk613E-d-Aaw37KAw-Zs9Gc7G6y754Rq-AwyTi7YQ1',
    tokenExpirationDate: tokenExpirationDate,
      intro: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'
  ),
];

List<TraderProfile> testTraderProfiles = [
  TraderProfile(
    fullName: 'Ruel Sison',
    email: 'rsjudge19@gmail.com',
    token: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ii0zMndiMC15aEQ1U2FyM01CTm82QyJ9.eyJpc3MiOiJodHRwczovL2NvbWJpbmVkb3RhaS5ldS5hdXRoMC5jb20vIiwic3ViIjoiVFNPY0MxaWZjdWdRejZOYXNjc29iZ3YxeVkxUXR0TFlAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxwZW9wbGUtYXBpIiwiaWF0IjoxNjE5NzcwMTc3LCJleHAiOjE2MTk4NTY1NzcsImF6cCI6IlRTT2NDMWlmY3VnUXo2TmFzY3NvYmd2MXlZMVF0dExZIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.lk1We2ISICepnLwYMWZd-rA3e05A6cr_jd2LyTiZTzBIQWT82LJyEYArRKW_AsGxWnGBusjZQD_4_8IZIBBaGI09y5l1GNt6tkQWNsfE2F2ujSuIiuw9w8_jPquNHp_j1o6gG6AQmtEUffQ-C9xOaHYu4VM7Hc-AX09h5YXk1CtTgAj87IRjyC6yAvkTc6I59lRUGj5osJybvHUlX8oqh5uFz2uwrSh4E7621-eCYZB_sO5FNxHSZq-hlUuigIwkWO6G3EP8vl3ZUntve6doNjE8xgSiwBPwHZnsydfyfQmyquk613E-d-Aaw37KAw-Zs9Gc7G6y754Rq-AwyTi7YQ2"',
    tokenExpirationDate: tokenExpirationDate,
      intro: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'
  ),
  TraderProfile(
    fullName: 'Professional Name',
    email: 'rsjudge20@gmail.com',
    token: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ii0zMndiMC15aEQ1U2FyM01CTm82QyJ9.eyJpc3MiOiJodHRwczovL2NvbWJpbmVkb3RhaS5ldS5hdXRoMC5jb20vIiwic3ViIjoiVFNPY0MxaWZjdWdRejZOYXNjc29iZ3YxeVkxUXR0TFlAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxwZW9wbGUtYXBpIiwiaWF0IjoxNjE5NzcwMTc3LCJleHAiOjE2MTk4NTY1NzcsImF6cCI6IlRTT2NDMWlmY3VnUXo2TmFzY3NvYmd2MXlZMVF0dExZIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.lk1We2ISICepnLwYMWZd-rA3e05A6cr_jd2LyTiZTzBIQWT82LJyEYArRKW_AsGxWnGBusjZQD_4_8IZIBBaGI09y5l1GNt6tkQWNsfE2F2ujSuIiuw9w8_jPquNHp_j1o6gG6AQmtEUffQ-C9xOaHYu4VM7Hc-AX09h5YXk1CtTgAj87IRjyC6yAvkTc6I59lRUGj5osJybvHUlX8oqh5uFz2uwrSh4E7621-eCYZB_sO5FNxHSZq-hlUuigIwkWO6G3EP8vl3ZUntve6doNjE8xgSiwBPwHZnsydfyfQmyquk613E-d-Aaw37KAw-Zs9Gc7G6y754Rq-AwyTi7YQ3',
    tokenExpirationDate: tokenExpirationDate,
      intro: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.'
  ),
];