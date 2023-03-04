import credentials from './smtp-credentials.js';


/* SmtpJS.com - v3.0.0 */
var Email = { send: function (a) { return new Promise(function (n, e) { a.nocache = Math.floor(1e6 * Math.random() + 1), a.Action = "Send"; var t = JSON.stringify(a); Email.ajaxPost("https://smtpjs.com/v3/smtpjs.aspx?", t, function (e) { n(e) }) }) }, ajaxPost: function (e, n, t) { var a = Email.createCORSRequest("POST", e); a.setRequestHeader("Content-type", "application/x-www-form-urlencoded"), a.onload = function () { var e = a.responseText; null != t && t(e) }, a.send(n) }, ajax: function (e, n) { var t = Email.createCORSRequest("GET", e); t.onload = function () { var e = t.responseText; null != n && n(e) }, t.send() }, createCORSRequest: function (e, n) { var t = new XMLHttpRequest; return "withCredentials" in t ? t.open(e, n, !0) : "undefined" != typeof XDomainRequest ? (t = new XDomainRequest).open(e, n) : t = null, t } };


function sendEmail(to, subject, body) {
    Email.send({
        Host: credentials.host,
        Username: credentials.username,
        Password: credentials.password,
        To: to,
        From: credentials.username,
        Subject: subject,
        Body: body
    }).then(message => {
        console.log(message);

        if (message == 'OK') {
            console.log(`Your message has been sent successfully to ${to}`);
        } else {
            console.log('Something went wrong. Please try again later.');
        }
    });
}

export default sendEmail;