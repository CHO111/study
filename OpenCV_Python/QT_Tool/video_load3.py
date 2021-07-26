# https://for-sign.tistory.com/40
from PyQt5 import QtCore, QtGui
from PyQt5 import QtWidgets, uic
from PyQt5.QtGui import QPixmap, QImage

import sys
import cv2
import numpy as np

from time import sleep
#비디오 재생을 위해 스레드 생성
import threading


# 1. qt를 사용하여 GUI 프로그램 환경 구축
class Ui(QtWidgets.QDialog):
    def __init__(self):
        super(Ui, self).__init__()
        uic.loadUi('video_load.ui', self)

        self.loadBtn = self.findChild(QtWidgets.QPushButton, 'loadBtn')
        self.loadBtn.clicked.connect(self.loadBtnClicked)
        self.procRun = self.findChild(QtWidgets.QPushButton, 'procRun')
        self.procRun.clicked.connect(self.procRunClicked)
        self.photo = self.findChild(QtWidgets.QLabel, 'photo')
        self.photo.setScaledContents(True)
        self.result = self.findChild(QtWidgets.QLabel, 'result')
        self.fnameEdit = self.findChild(QtWidgets.QLineEdit, 'fnameEdit')
        self.fnameEdit.clear()
        self.out_check = False

        self.show()


    def processingImage(self, img_gray, img_src):
        # 여기에 이미지 프로세싱을 진행하고 output으로 리턴하면 오른쪽에 결과 영상 출력됨
        # output = img_src.copy() #원본영상 그대로 리턴
        output = img_gray.copy()  # 그래이 영상 리턴
        return output

    def displayOutputImage(self, img_dst, mode):
        img_info = img_dst.shape
        if img_dst.ndim == 2:
            qImg = QImage(img_dst, img_info[1], img_info[0], img_info[1] * 1, QImage.Format_Grayscale8)
        else:
            qImg = QImage(img_dst, img_info[1], img_info[0], img_info[1] * img_info[2],QImage.Format_BGR888)

        self.pixmap = QtGui.QPixmap(qImg)
        self.p = self.pixmap.scaled(600, 450, QtCore.Qt.IgnoreAspectRatio)  # 프레임 크기 조정

        if mode == 0:
            self.photo.setPixmap(self.p)
            self.photo.update()  # 프레임 띄우기
        else:
            self.result.setPixmap(self.p)
            self.result.update()  # 프레임 띄우기

        sleep(0.01)  # 영상 1프레임당 0.01초로 이걸로 영상 재생속도 조절하면됨 0.02로하면 0.5배속인거임

    def procRunClicked(self):
        self.out_check = True



    def loadBtnClicked(self):
        path = 'figure/'
        filter = "All Videos(*.mp4; *.mov; *.avi);;MOV (*.mov);;MP4(*.mp4);;AVI(*.avi)"
        fname = QtWidgets.QFileDialog.getOpenFileName(self, "파일로드", path, filter)
        self.filename = str(fname[0])
        self.fnameEdit.setText(self.filename)
        self.video_thread()


    def Video_to_frame(self, MainWindow):
        cap = cv2.VideoCapture(self.filename) #저장된 영상 가져오기 프레임별로 계속 가져오는 듯
        ###cap으로 영상의 프레임을 가지고와서 전처리 후 화면에 띄움###
        while True:
            self.ret, self.frame = cap.read() #영상의 정보 저장
            if self.ret:
                self.displayOutputImage(self.frame, 0)
                if self.out_check == True:
                    self.process_result()
                    self.displayOutputImage(self.frame_out, 1)
            else:
                break

        cap.release()
        cv2.destroyAllWindows()

    def process_result(self):
        self.frame_out = cv2.cvtColor(self.frame, cv2.COLOR_BGR2GRAY)
    #   여기부터 작업할 코드 작성하면 됩니다.

    def video_thread(self):
        thread = threading.Thread(target=self.Video_to_frame, args=(self,))
        thread.daemon = True  # 프로그램 종료시 프로세스도 함께 종료 (백그라운드 재생 X)
        thread.start()


app = QtWidgets.QApplication(sys.argv)
window = Ui()
app.exec_()



