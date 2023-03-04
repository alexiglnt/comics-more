export function htmlEmailWelcome(username) {
    let content =
        `<!DOCTYPE html>
            <html>
                <head>
                    <title>Bienvenue sur Comics More</title>
                    <style>
                    body {
                        font-family: Arial, sans-serif;
                        color: #333333;
                        line-height: 1.5;
                    }

                    h1 {
                        font-size: 28px;
                        margin-bottom: 20px;
                    }

                    p {
                        font-size: 16px;
                        margin-bottom: 10px;
                    }

                    .signature {
                        margin-top: 30px;
                        font-style: italic;
                    }
                    </style>
                </head>
                <body>
                    <h1>Bonjour ${username},</h1>

                    <p>Nous sommes ravis de vous accueillir sur <b>Comics More</b>, votre nouvelle source de lecture en ligne de comics. Nous avons rassemblé une collection de titres incroyables que vous pourrez lire à tout moment et de n'importe où.</p>

                    <p>Notre plateforme facile à utiliser vous permet de naviguer rapidement parmi les catégories et de trouver facilement votre prochaine lecture préférée. De plus, notre équipe travaille dur pour ajouter régulièrement de nouveaux titres, afin que vous ayez toujours quelque chose de nouveau à découvrir.</p>

                    <p>Nous sommes convaincus que vous allez adorer notre site web, alors n'hésitez pas à parcourir notre catalogue dès maintenant et à nous faire part de vos commentaires et suggestions.</p>

                    <p>Merci d'avoir rejoint <b>Comics More</b>. Nous sommes impatients de vous offrir une expérience de lecture inoubliable !</p>

                    <div class="signature">
                        <p>Cordialement,</p>
                        <p>L'équipe Comics More</p>
                    </div>
                </body>
            </html>`;

    return content;
}


export function htmlFacture(paymentInfosOrder) {

    return `<!DOCTYPE html>
            <html>
                <head>
                    <style>
                        .invoice-box {
                            max-width: 800px;
                            margin: auto;
                            padding: 30px;
                            border: 1px solid #eee;
                            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
                            font-size: 16px;
                            line-height: 24px;
                            font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                            color: #555;
                        }

                        .invoice-box table {
                            width: 100%;
                            line-height: inherit;
                            text-align: left;
                        }

                        .invoice-box table td {
                            padding: 5px;
                            vertical-align: top;
                        }

                        .invoice-box table tr td:nth-child(2) {
                            text-align: right;
                        }

                        .invoice-box table tr.top table td {
                            padding-bottom: 20px;
                        }

                        .invoice-box table tr.top table td.title {
                            font-size: 45px;
                            line-height: 45px;
                            color: #333;
                        }

                        .invoice-box table tr.information table td {
                            padding-bottom: 40px;
                        }

                        .invoice-box table tr.heading td {
                            background: #eee;
                            border-bottom: 1px solid #ddd;
                            font-weight: bold;
                        }

                        .invoice-box table tr.details td {
                            padding-bottom: 20px;
                        }

                        .invoice-box table tr.item td {
                            border-bottom: 1px solid #eee;
                        }

                        .invoice-box table tr.item.last td {
                            border-bottom: none;
                        }

                        .invoice-box table tr.total td:nth-child(2) {
                            border-top: 2px solid #eee;
                            font-weight: bold;
                        }

                        @media only screen and (max-width: 600px) {
                            .invoice-box table tr.top table td {
                                width: 100%;
                                display: block;
                                text-align: center;
                            }

                            .invoice-box table tr.information table td {
                                width: 100%;
                                display: block;
                                text-align: center;
                            }
                        }

                        /** RTL **/
                        .invoice-box.rtl {
                            direction: rtl;
                            font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                        }

                        .invoice-box.rtl table {
                            text-align: right;
                        }

                        .invoice-box.rtl table tr td:nth-child(2) {
                            text-align: left;
                        }
                    </style>
                </head>

                <body>
                    <div class="invoice-box">
                        <table cellpadding="0" cellspacing="0">
                            <tr class="top">
                                <td colspan="2">
                                    <table>
                                        <tr>
                                            <td class="title">
                                                <img src="https://comicsmore.s3.eu-west-3.amazonaws.com/Docteur+Fatalis+T1+-+Mort+dans+l_apr%C3%A8s-midi/001.jpg" style="width:100px; max-width:100px;" />
                                            </td>

                                            <td>
                                                ID Ordre : ${paymentInfosOrder.orderId} <br />
                                                ID Paiement : ${paymentInfosOrder.paymentId} <br />
                                                ID Payeur : ${paymentInfosOrder.payerId} <br />
                                                Date de création : ${paymentInfosOrder.create_time} <br />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr class="information">
                                <td colspan="2">
                                    <table>
                                        <tr>
                                            <td>
                                                Comics More<br />
                                                Site web de lecture de comics<br />
                                                contact.comicsmore@gmail.com <br />
                                            </td>

                                            <td>
                                                ${paymentInfosOrder.name} <br />
                                                Membre utilisateur <br />
                                                ${paymentInfosOrder.mail}
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr class="heading">
                                <td>Méthode de paiement</td>

                                <td>Check #</td>
                            </tr>

                            <tr class="details">
                                <td>PayPal</td>

                                <td> Oui </td>
                            </tr>

                            <tr class="heading">
                                <td>Prix crédit</td>

                                <td>Unité</td>
                            </tr>

                            <tr class="details">
                                <td>2 €</td>

                                <td> Oui </td>
                            </tr>

                            <tr class="heading">
                                <td>Item</td>

                                <td>Prix</td>
                            </tr>

                            <tr class="item">
                                <td> Crédits x ${paymentInfosOrder.nbCredits} </td>

                                <td> ${paymentInfosOrder.price} € </td>
                            </tr>

                            <tr class="total">
                                <td></td>

                                <td>Total : ${paymentInfosOrder.price} € </td>
                            </tr>
                        </table>
                    </div>
                </body>
            </html>`
}
