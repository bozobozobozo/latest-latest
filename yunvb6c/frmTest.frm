VERSION 5.00
Begin VB.Form frmTest 
   Caption         =   "Form1"
   ClientHeight    =   5445
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8550
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   5445
   ScaleWidth      =   8550
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   120
      TabIndex        =   7
      Text            =   "192.168.1.110"
      Top             =   360
      Width           =   4275
   End
   Begin VB.CommandButton Command4 
      Caption         =   "EXIT"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   7200
      TabIndex        =   6
      Top             =   4560
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   7560
      TabIndex        =   4
      Text            =   "1"
      Top             =   60
      Width           =   975
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Go"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   5940
      TabIndex        =   3
      Top             =   960
      Width           =   735
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmTest.frx":0000
      Left            =   120
      List            =   "frmTest.frx":0002
      TabIndex        =   2
      Text            =   "Enter Base IP adress Above"
      Top             =   960
      Width           =   5595
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Go with Repeat"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6840
      TabIndex        =   1
      Top             =   900
      Width           =   1755
   End
   Begin VB.TextBox Text2 
      Height          =   3795
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   1440
      Width           =   5595
   End
   Begin VB.Label Label3 
      Caption         =   "Command:"
      Height          =   195
      Left            =   120
      TabIndex        =   9
      Top             =   720
      Width           =   2115
   End
   Begin VB.Label Label2 
      Caption         =   "Board IP Address:"
      Height          =   195
      Left            =   120
      TabIndex        =   8
      Top             =   60
      Width           =   1515
   End
   Begin VB.Label Label1 
      Caption         =   "Repeat"
      Height          =   255
      Left            =   6660
      TabIndex        =   5
      Top             =   120
      Width           =   615
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Combo1_Click()

    '''Command1.Value = True

End Sub


Private Sub Command1_Click()
    Dim rpt As Integer
    Dim x As Integer
    
    
    MousePointer = vbHourglass
    rpt = Val(Text1.Text)
    
    For x = 1 To rpt
    'Print x
     Text2.Text = GetUrlSource(Combo1.Text)
    Next

    'Text2.Text = GetUrlSource(Combo1.Text)
    MousePointer = vbDefault
End Sub

Private Sub Command2_Click()
    MousePointer = vbHourglass
    Text2.Text = GetUrlSource(Combo1.Text)
    MousePointer = vbDefault
End Sub


Private Sub Command3_Click()
    MousePointer = vbHourglass
    Text2.Text = GetUrlSource(Combo1.Text)
    MousePointer = vbDefault
End Sub

Private Sub Command4_Click()
End
End Sub


Private Sub Command5_Click()

Combo1.Clear
Combo1.AddItem "http://" & Text3.Text & "/arduino/on^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/off^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/step^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/back^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/step^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/step^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/stop^^"



End Sub


Private Sub Form_Load()

Combo1.Clear
Combo1.AddItem "http://" & Text3.Text & "/arduino/on^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/off^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/step^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/back^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/step^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/step^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/stop^^"

Combo1.ListIndex = 2
End Sub

Private Sub Text3_Change()
Combo1.Clear
Combo1.AddItem "http://" & Text3.Text & "/arduino/on^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/off^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/step^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/back^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/step^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/step^^"
Combo1.AddItem "http://" & Text3.Text & "/arduino/stop^^"

Combo1.ListIndex = 2

End Sub


