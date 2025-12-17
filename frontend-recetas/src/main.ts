// src/main.ts
import { bootstrapApplication } from '@angular/platform-browser';
import { App } from './app/app';
import { provideHttpClient, HTTP_INTERCEPTORS } from '@angular/common/http';
import { appConfig } from './app/app.config';
import { JwtInterceptor } from './app/servicios/jwt.interceptor';

bootstrapApplication(App, {
  ...appConfig,
  providers: [
    ...(appConfig.providers ?? []), // mantener los providers existentes
    provideHttpClient(),            // HttpClient para peticiones HTTP
    {
      provide: HTTP_INTERCEPTORS,
      useClass: JwtInterceptor,
      multi: true
    }
  ]
})
.catch(err => console.error(err));
