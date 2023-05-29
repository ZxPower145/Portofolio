import os
from datetime import datetime
from files.emailing import send_email
import cv2
import glob
from threading import Thread
import streamlit as st

st.title("Motion Detector")
st.info("This WebApp detects movement with your camera and snaps a picture, which it then sends to your email.")
receiver = st.text_input("Enter your email address (must be Gmail !):")

arm = st.button("ARM!")
exit_btn = st.button("Exit")
video_active = False


def clean_folder():
    images_folder = glob.glob("files/images/*")
    for image in images_folder:
        os.remove(image)


if arm:
    streamlit_image = st.image([])
    video = cv2.VideoCapture(0)
    video_active = True

    first_frame = None
    status_list = []
    count = 1

    while video_active:
        status = 0
        check, frame = video.read()
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        grey_gau = cv2.GaussianBlur(gray, (21, 21), 0)
        now = datetime.now()

        if first_frame is None:
            first_frame = grey_gau

        delta_frame = cv2.absdiff(first_frame, grey_gau)

        thresh_frame = cv2.threshold(delta_frame, 60, 255, cv2.THRESH_BINARY)[1]
        dil_frame = cv2.dilate(thresh_frame, None, iterations=2)

        contours, check = cv2.findContours(dil_frame, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        cv2.putText(img=frame,
                    text=now.strftime("%A"),
                    org=(50, 50),
                    fontFace=cv2.FONT_HERSHEY_PLAIN,
                    fontScale=1,
                    color=(0, 0, 0),
                    thickness=2,
                    lineType=cv2.LINE_AA)

        cv2.putText(img=frame,
                    text=now.strftime("%D - %H:%M:%S"),
                    org=(50, 70),
                    fontFace=cv2.FONT_HERSHEY_PLAIN,
                    fontScale=1,
                    color=(0, 0, 0),
                    thickness=2,
                    lineType=cv2.LINE_AA)

        for contour in contours:
            if cv2.contourArea(contour) < 5000:
                continue

            x, y, w, h = cv2.boundingRect(contour)
            rectangle = cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 0, 255), 3)

            if rectangle.any():
                status = 1
                cv2.imwrite(f"files/images/image{count}.png", frame)
                count = count + 1
                all_imgs = glob.glob("files/images/*.png")
                img_index = int(len(all_imgs) / 2)
                image_to_send = all_imgs[img_index]

        status_list.append(status)
        status_list = status_list[-2:]

        if status_list[0] == 1 and status_list[1] == 0:

            email_thread = Thread(target=send_email, args=(image_to_send, receiver,))
            email_thread.daemon = True
            email_thread.start()

        streamlit_image.image(frame)

        if exit_btn:
            video_active = False
            video.release()
            st.stop()
            break

if not video_active:
    clean_thread = Thread(target=clean_folder)
    clean_thread.daemon = True
    clean_thread.start()
