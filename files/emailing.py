import os
import smtplib
import imghdr
from email.message import EmailMessage

PASS = os.environ.get("PASS")
SENDER = "costinbogdan145@gmail.com"
RECEIVER = "costinbogdan145@gmail.com"


def send_email(image, RECEIVER_LC=RECEIVER):
    email_message = EmailMessage()
    email_message["Subject"] = "Motion Detected!"
    email_message.set_content("The camera has detected som ruckus!")

    with open(image, "rb") as file:
        content = file.read()

    email_message.add_attachment(content, maintype="image", subtype=imghdr.what(None, content))

    gmail = smtplib.SMTP("smtp.gmail.com", 587)
    gmail.ehlo()
    gmail.starttls()
    gmail.login(SENDER, PASS)
    gmail.sendmail(SENDER, RECEIVER_LC, email_message.as_string())
    gmail.quit()
