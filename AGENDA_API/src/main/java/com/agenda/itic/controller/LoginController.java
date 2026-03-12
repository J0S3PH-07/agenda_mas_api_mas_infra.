package com.agenda.itic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {

    @GetMapping("/login-success")
    @ResponseBody
    public String loginSuccess(@RequestParam String token) {
        return "<!DOCTYPE html><html><head><title>Login exitoso</title>" +
               "<style>body{font-family:Arial,sans-serif;display:flex;justify-content:center;align-items:center;height:100vh;margin:0;background:#f0f2f5;}" +
               ".card{background:white;padding:2rem;border-radius:12px;box-shadow:0 2px 16px rgba(0,0,0,.1);max-width:600px;width:90%;text-align:center;}" +
               "h2{color:#4caf50;margin-bottom:1rem;}p{color:#555;margin-bottom:1rem;}" +
               ".token-box{background:#f5f5f5;border:1px solid #ddd;border-radius:6px;padding:12px;word-break:break-all;font-size:11px;font-family:monospace;text-align:left;max-height:80px;overflow:hidden;}" +
               "button{margin-top:1rem;padding:10px 24px;background:#1a73e8;color:white;border:none;border-radius:6px;cursor:pointer;font-size:14px;}" +
               "button:hover{background:#1558b0;}.ok{color:#4caf50;font-weight:bold;}</style></head>" +
               "<body><div class='card'>" +
               "<h2>✅ Login exitoso</h2>" +
               "<p>Tu token JWT ha sido guardado en <strong>Local Storage</strong> con la clave <code>token</code>.</p>" +
               "<div class='token-box' id='tkn'>" + token + "</div>" +
               "<button onclick=\"navigator.clipboard.writeText('" + token + "').then(()=>{this.textContent='¡Copiado!';this.style.background='#4caf50';})\">📋 Copiar Token</button>" +
               "<p style='margin-top:1.5rem;font-size:13px;color:#888;'>Usa este token en Postman o tu frontend como:<br><code>Authorization: Bearer &lt;token&gt;</code></p>" +
               "</div>" +
               "<script>localStorage.setItem('token','" + token + "');</script>" +
               "</body></html>";
    }
}
