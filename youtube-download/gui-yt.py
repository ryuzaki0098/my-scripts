#!/bin/bash env python

import sys
from PyQt5.QtWidgets import (
    QApplication,
    QWidget,
    QPushButton,
    QLineEdit,
    QLabel,
    QMessageBox,
    QProgressBar,
)
from PyQt5.QtCore import QThread, pyqtSignal
from pytube import YouTube
import os


class DownloadThread(QThread):
    change_value = pyqtSignal(int)

    def __init__(self, url, path):
        QThread.__init__(self)
        self.url = url
        self.path = path

    def run(self):
        yt = YouTube(self.url)
        yt = (
            yt.streams.filter(progressive=True, file_extension="mp4")
            .order_by("resolution")
            .desc()
            .first()
        )
        yt.download(self.path)
        self.change_value.emit(100)


class App(QWidget):
    def __init__(self):
        super().__init__()
        self.title = "Youtube Downloader"
        self.left = 10
        self.top = 10
        self.width = 640
        self.height = 480
        self.initUI()

    def initUI(self):
        self.setWindowTitle(self.title)
        self.setGeometry(self.left, self.top, self.width, self.height)

        self.textbox = QLineEdit(self)
        self.textbox.move(20, 20)
        self.textbox.resize(280, 40)

        self.label = QLabel(self)
        self.label.setText("Enter the url")
        self.label.move(20, 70)

        self.button = QPushButton("Download", self)
        self.button.move(20, 120)

        self.progress = QProgressBar(self)
        self.progress.setGeometry(20, 170, 280, 25)

        self.button.clicked.connect(self.on_click)
        self.show()

    def on_click(self):
        url = self.textbox.text()
        if url == "":
            QMessageBox.question(
                self, "Error", "Please enter a url", QMessageBox.Ok, QMessageBox.Ok
            )
            self.textbox.setFocus()
            return
        self.progress.setValue(0)
        self.download(url)

    def download(self, url):
        self.thread = DownloadThread(url, os.getcwd())
        self.thread.change_value.connect(self.setProgressVal)
        self.thread.start()

    def setProgressVal(self, val):
        self.progress.setValue(val)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    ex = App()
    sys.exit(app.exec_())
