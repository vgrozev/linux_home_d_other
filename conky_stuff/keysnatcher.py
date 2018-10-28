#!/usr/bin/env python
# ==============================================================================
# title			:TheeMahn's O/S Builder
# description	:Repairs broken repositories and snatches missing GPG keys.
# author		:theemahn <theemahn@ultimateedition.info>
# date			:03/04/2016
# version		:1.1.1
# usage			:tmosb --help
# manual		:man tmosb
# notes			:See change-log below for further information.
# Change-log:
#		1.0:	First public release
# 		1.0.1:	Added bc to dependancy list
#				Removed locale was causing minor issues
#
#		1.0.2:	Added fix routine for missing repositories
#				Added Server Timeout function for IPV6
#				Many bug fixes in permission rights.
#
#		1.0.3:	Wrote help system. Not a fantastic job, but I hope it
#				gets the point across.
#
#		1.0.4:	Adjusted servers, added version dumping header.
#				Now checks permissions prior to engaging software.
#				Added eyecandy routines & a new one Encapsulate.
#				Adjusted Help system and commands.
#
#		1.0.5	Added fixing of 403 Forbidden errors.
#				Repaired bash_autocompletion to coincide with options
#
#		1.0.6	Added ability to skip connectivity tests.
#				Adjusted eyecandy routines.
#				Wrote a manual in man format, pdf and postscript.
#		1.0.7	Added repair of "Failure to fetch" (Architecture)
#				related issues.
#
#		1.0.8	Added ueserver.space to the keyserver mix (3+ million keys)
#
#		1.0.9	Added repair of duplicate sources.
#
#		1.1.0	Fixed sites being down. (don't count on anything being
#				up mentality has stepped in).  Yes, our servers go down
#				too.  Donate damn it ;)
#
#		1.1.1	Added keyserver switch allows for manual selection of keyserver
#				Updated manpages, ps and pdf manual
#				Added repairing of duplicate sources.
#				Introduction of GUI based application
# ==============================================================================
# Version Control

#INTERNAL VARIBLES
PROGNAME="KeySnatcher"
APPNAME="keysnatcher"
BUILDDATE="03/04/2016"
VERSION="1.1.1"
WEBSITE="ultimateedition.info"
AUTHOR="TheeMahn"

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_keysnatcher(object):
    def setupUi(self, keysnatcher):
        keysnatcher.setObjectName(_fromUtf8("keysnatcher"))
        keysnatcher.resize(270, 84)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(_fromUtf8("/usr/share/ultimate_edition/logo.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        keysnatcher.setWindowIcon(icon)
        self.centralwidget = QtGui.QWidget(keysnatcher)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.Go = QtGui.QPushButton(self.centralwidget)
        self.Go.setGeometry(QtCore.QRect(180, 40, 71, 23))
        self.Go.setObjectName(_fromUtf8("Go"))
        self.operation = QtGui.QComboBox(self.centralwidget)
        self.operation.setGeometry(QtCore.QRect(80, 10, 171, 23))
        self.operation.setObjectName(_fromUtf8("operation"))
        self.preform = QtGui.QLabel(self.centralwidget)
        self.preform.setGeometry(QtCore.QRect(20, 10, 61, 16))
        self.preform.setObjectName(_fromUtf8("preform"))
        self.pushButton = QtGui.QPushButton(self.centralwidget)
        self.pushButton.setGeometry(QtCore.QRect(100, 40, 71, 23))
        self.pushButton.setObjectName(_fromUtf8("pushButton"))
        self.pushButton_2 = QtGui.QPushButton(self.centralwidget)
        self.pushButton_2.setGeometry(QtCore.QRect(20, 40, 71, 23))
        self.pushButton_2.setObjectName(_fromUtf8("pushButton_2"))
        keysnatcher.setCentralWidget(self.centralwidget)
        self.statusbar = QtGui.QStatusBar(keysnatcher)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        keysnatcher.setStatusBar(self.statusbar)

        self.retranslateUi(keysnatcher)
        QtCore.QMetaObject.connectSlotsByName(keysnatcher)

    def retranslateUi(self, keysnatcher):
        keysnatcher.setWindowTitle(_translate("keysnatcher", "KeySnatcher", None))
        self.Go.setText(_translate("keysnatcher", "Go", None))
        self.preform.setText(_translate("keysnatcher", "Preform:", None))
        self.pushButton.setText(_translate("keysnatcher", "Help", None))
        self.pushButton_2.setText(_translate("keysnatcher", "Quit", None))

