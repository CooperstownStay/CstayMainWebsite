Imports System
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.IO
Imports System.Reflection
Imports System.Runtime.InteropServices

Public Class ImageFast
	<DllImport("gdiplus.dll", ExactSpelling:=True, CharSet:=CharSet.Unicode)> _
	Private Shared Function GdipLoadImageFromFile(ByVal filename As String, ByRef image As IntPtr) As Integer
	End Function

	<DllImport("gdiplus.dll", ExactSpelling:=True, CharSet:=CharSet.Unicode)> _
	Private Shared Function GdiplusStartup(ByRef token As IntPtr, ByRef input As StartupInput, ByRef output As StartupOutput) As Integer
	End Function

	<DllImport("gdiplus.dll", ExactSpelling:=True, CharSet:=CharSet.Unicode)> _
	Private Shared Function GdiplusShutdown(ByVal token As IntPtr) As Integer
	End Function

	<DllImport("gdiplus.dll", ExactSpelling:=True, CharSet:=CharSet.Unicode)> _
	Private Shared Function GdipGetImageType(ByVal image As IntPtr, ByRef type As GdipImageTypeEnum) As Integer
	End Function

	Private Shared gdipToken As IntPtr = IntPtr.Zero

	Shared Sub New()
#If DEBUG Then
        Console.WriteLine("Initializing GDI+")
#End If
		If gdipToken = IntPtr.Zero Then
			Dim input As StartupInput = StartupInput.GetDefaultStartupInput()
			Dim output As StartupOutput

			Dim status As Integer = GdiplusStartup(gdipToken, input, output)
#If DEBUG Then
            If status = 0 Then
                Console.WriteLine("Initializing GDI+ completed successfully")
            End If
#End If
			If status = 0 Then
				AddHandler AppDomain.CurrentDomain.ProcessExit, AddressOf Cleanup_Gdiplus
			End If
		End If
	End Sub

	Private Shared Sub Cleanup_Gdiplus(ByVal sender As Object, ByVal e As EventArgs)
#If DEBUG Then
        Console.WriteLine("GDI+ shutdown entered through ProcessExit event")
#End If
		If gdipToken <> IntPtr.Zero Then
			GdiplusShutdown(gdipToken)
		End If

#If DEBUG Then
#End If
		Console.WriteLine("GDI+ shutdown completed")
	End Sub

	Private Shared bmpType As Type = GetType(System.Drawing.Bitmap)
	Private Shared emfType As Type = GetType(System.Drawing.Imaging.Metafile)

	Public Shared Function FromFile(ByVal filename As String) As Image
		filename = Path.GetFullPath(filename)
		Dim loadingImage As IntPtr = IntPtr.Zero

		' We are not using ICM at all, fudge that, this should be FAAAAAST!
		If GdipLoadImageFromFile(filename, loadingImage) <> 0 Then
			Throw New Exception("GDI+ threw a status error code.")
		End If

		Dim imageType As GdipImageTypeEnum
		If GdipGetImageType(loadingImage, imageType) <> 0 Then
			Throw New Exception("GDI+ couldn't get the image type")
		End If

		Select Case imageType
			Case GdipImageTypeEnum.Bitmap
				Return DirectCast(bmpType.InvokeMember("FromGDIplus", BindingFlags.NonPublic Or BindingFlags.[Static] Or BindingFlags.InvokeMethod, Nothing, Nothing, New Object() {loadingImage}), Bitmap)
			Case GdipImageTypeEnum.Metafile
				Return DirectCast(emfType.InvokeMember("FromGDIplus", BindingFlags.NonPublic Or BindingFlags.[Static] Or BindingFlags.InvokeMethod, Nothing, Nothing, New Object() {loadingImage}), Metafile)
		End Select

		Throw New Exception("Couldn't convert underlying GDI+ object to managed object")
	End Function

	Private Sub New()
	End Sub
End Class

<StructLayout(LayoutKind.Sequential)> _
Friend Structure StartupInput
	Public GdiplusVersion As Integer
	Public DebugEventCallback As IntPtr
	Public SuppressBackgroundThread As Boolean
	Public SuppressExternalCodecs As Boolean

	Public Shared Function GetDefaultStartupInput() As StartupInput
		Dim result As New StartupInput()
		result.GdiplusVersion = 1
		result.SuppressBackgroundThread = False
		result.SuppressExternalCodecs = False
		Return result
	End Function
End Structure

<StructLayout(LayoutKind.Sequential)> _
Friend Structure StartupOutput
	Public Hook As IntPtr
	Public Unhook As IntPtr
End Structure

Friend Enum GdipImageTypeEnum
	Unknown = 0
	Bitmap = 1
	Metafile = 2
End Enum
