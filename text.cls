'<<--BEGIN_CODE_SEGMENT_PRINTHEADER-->>
Dim sql, wrkMth

printlayoutName = "rptMonitorApt"
tittle = "Monitor Appointments"
MainTable = ""
currSto = Trim(request.QueryString("spid"))
SletSto = Trim(request.QueryString("spids"))
mth = Trim(request.QueryString("wrkmID"))
dat1 = Trim(request.QueryString("dpid"))
dat2 = Trim(request.QueryString("dp1id"))
dat11 = Trim(request.QueryString("dpid1"))
dat21 = Trim(request.QueryString("dp1id1"))

response.Clear
lol = GetTotalPending
'Response.Write " " & lol & " "
gtc = GetTotalConfirmed
'Response.Write "" & gtc & ""
gtcanc = GetTotalCancelled
'Response.Write "" & gtcanc & ""
gtcompleted = GetTotalCompleted
'Response.Write "" & gtcompleted & ""


response.write "<!DOCTYPE html>"
response.write "<html>"
response.write "  <head>"
response.write "     <title>" & tittle & "</title>"
response.write "     <link rel='stylesheet' type='text/css' href='fontawesome-free-6.4.0-web/css/all.css'/>"
StylesAdded
DashBoardStylesAdded
response.write "  </head>"
response.write "  <body>"

AppointmentSummary


' if mth = "" and dat1 = "" and dat2 = "" then
'     TopHead
' Else

    sqlw = " SELECT RefVal, VisitationID, PatientID, AppointmentID, AppointDate, WorkingMonthID, SpecialistID"
    sqlw = sqlw & " FROM ("
    sqlw = sqlw & "     SELECT AppointmentID as RefVal, AppointmentID As VisitationID, PatientID, AppointmentID, AppointDate, AppointMonthID AS WorkingMonthID, MedicalStaffID AS SpecialistID"
    sqlw = sqlw & "     FROM Appointment "
    sqlw = sqlw & "     UNION ALL"
    sqlw = sqlw & "     SELECT erq.EMRRequestID as RefVal, v.VisitationID, v.PatientID, 'Request' as AppointmentID, CONVERT(DATETIME, CONVERT(NVARCHAR(MAX), er.COLUMN1), 113) AS AppointDate, v.WorkingMonthID, CONVERT(VARCHAR(MAX), er.COLUMN3) AS SpecialistID "
    sqlw = sqlw & "     FROM EMRResults er, Visitation v, EMRRequest erq"
    sqlw = sqlw & "     WHERE er.EMRRequestID = erq.EMRRequestID AND erq.VisitationID = v.VisitationID"
    sqlw = sqlw & "     And EMRDataID = 'FNH24001' AND EMRComponentID = 'FNH24001001'"
    sqlw = sqlw & " ) AS data "
    If dat1 <> "" And dat2 <> "" Then
        mth = ""
        If dat11 = "" And dat21 = "" Then
            dat11 = "00:00:00"
            dat21 = "23:59:59"
        End If
        sqlw = sqlw & " WHERE Appointdate BETWEEN  '" & dat1 & " " & dat11 & "' AND '" & dat2 & " " & dat21 & "' "
        sqlWhere = " WHERE Appointdate BETWEEN '" & dat1 & " " & dat11 & "' AND '" & dat2 & " " & dat21 & "' "
    ElseIf mth <> "" Then
        dat1 = ""
        dat2 = ""
        dat11 = ""
        dat21 = ""
        If mth = "All" Then
            mth = ""
        End If
        If mth <> "" Then
            sqlw = sqlw & " WHERE WorkingMonthID = '" & mth & "' "
            sqlWhere = " WHERE WorkingMonthID = '" & mth & "' "
        End If
    Else
        mth = GetCurrWrkmnt("Visitation")
        If mth <> "" Then
            sqlw = sqlw & " WHERE WorkingMonthID = '" & mth & "' AND Appointdate > GETDATE() - 1"
            sqlWhere = " WHERE WorkingMonthID = '" & mth & "' AND Appointdate > GETDATE() - 1 "
        End If
    End If
    If mth = "" And dat1 = "" And dat2 = "" Then
        WHAD = "WHERE"
    Else
        WHAD = "AND"
    End If
    If currSto <> "All" And currSto <> "" And SletSto = "" Then
        sqlw = sqlw & " " & WHAD & " SpecialistID = '" & currSto & "' "
    ElseIf SletSto <> "" Then
        currSto = ""
        sqlw = sqlw & " " & WHAD & " SpecialistID IN (" & getValuesInString(SletSto) & ")"
    End If
    sqlw = sqlw & " ORDER By AppointDate "
    ' response.write sqlw
    DisplayReport1 sqlw

' End if
ScpAdded
TableEXScp
response.write "  </body>"
response.write "</html>"

Sub DisplayReport1(sql)
    Dim rst

    Set rst = CreateObject("ADODB.Recordset")
    rst.open qryPro.FltQry(sql), conn, 3, 4

    TopHead
    If rst.RecordCount > 0 Then
        rst.movefirst
        
        response.write "      <div class='cnt-body p15 mlr25'>"
        TableEX
        ' response.write "        <div class='tab-table tbl-main mil'>"
        response.write "          <div class='table-holder'>"
        response.write "            <table class='tbl2' id='tbl'>"
        response.write "              <thead class='tbl-h2'>"
        response.write "                <tr>"
        response.write "                  <th data-sort='none' class='fh2 t-left'>#</th>"
        response.write "                  <th data-sort='none' class='fh2 t-left'>Appointment No.</th>"
        response.write "                  <th data-sort='none' class='fh2 t-left'>Patient</th>"
        response.write "                  <th data-sort='none' class='fh2 t-left'>Phone#</th>"
        response.write "                  <th data-sort='none' class='fh2 t-left'>Specialist</th>"
        response.write "                  <th data-sort='none' class='fh2 t-left'>Date</th>"
        response.write "                  <th data-sort='none' class='fh2 t-left'>Status</th>"
        response.write "                </tr>"
        response.write "              </thead>"
        response.write "              <tbody class='tbl-b2'>"

        Do While Not rst.EOF
          pos = rst.AbsolutePosition
          vst = rst.fields("VisitationID")
          rfvl = rst.fields("RefVal")
          aptID = rst.fields("AppointmentID")
          patID = rst.fields("PatientID")
          aptDt = rst.fields("AppointDate")
          splst = rst.fields("SpecialistID")
          styl1 = ""
          aptStat = GetComboNameFld("Appointment", rfvl, "AppointmentTypeID")

          hrefc = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=rptBookingCalendar&PositionForTableName=WorkingDay&WorkingDayID=DAY20160401&splstID=" & splst & "&VisitationID=" & vst
          If aptID = "Request" Then
            parts = GetDateTimeParts(aptDt)
            dtyrs = parts(0)
            dtmth = parts(1)
            dtdy = parts(2)
            dtym = parts(3)

            styl = " style='background: cornsilk;' "
            If ApptCreated(rfvl) Then
                styl = " style='display: none;' "
                styl1 = " style='display: none;' "
            End If
            href = "wpgAppointment.asp?PageMode=AddNew"
            href = href & "&AppointmentCatID=A001"
            href = href & "&AppointmentCatTypeID=A001"
            href = href & "&KeyPrefix=" & rfvl
            href = href & "&PatientID=" & patID
            href = href & "&MedicalStaffID=" & splst
            href = href & "&SpecialistTypeID=000"
            href = href & "&SpecialistID=" & splst
            href = href & "&AppointStartTimeID=" & dtym
            href = href & "&AppointEndTimeID=" & "2355" 'Last Entry'
            href = href & "&AppointYearID=YRS" & dtyrs
            href = href & "&AppointMonthID=MTH" & dtyrs & dtmth
            href = href & "&AppointDayID=DAY" & dtyrs & dtmth & dtdy
            ' aptID = "<div class='df'>" & GetNewLink(href, "Book", "btsty bss") & GetNewLink1(hrefc, "<i class='fa-solid fa-calendar-day plr10'></i>", "btsty bss") & "</div>"
            aptID = "<div class='df'>" & GetNewLink(href, "Book", "btsty bss") & "</div>"
          Else
            styl = ""
            href = "wpgAppointment.asp?PageMode=ProcessSelect&AppointmentID=" & aptID
            aptID = GetNewLink(href, aptID, "btsty aln pm")
          End If
          response.write "                <tr " & styl1 & ">"
          response.write "                  <td " & styl & ">" & pos & "</td>"
          response.write "                  <td " & styl & ">" & aptID & "</td>"
          response.write "                  <td " & styl & ">" & GetComboName("Patient", patID) & "</td>"
          response.write "                  <td " & styl & ">" & GetComboNameFld("Patient", patID, "residencephone") & "</td>"
          response.write "                  <td " & styl & "><div class='df'>" & GetNewLink1(hrefc, "<i class='fa-solid fa-calendar-day'></i>", "btsty bss") & GetComboName("Specialist", splst) & "</div></td>"
          response.write "                  <td " & styl & ">" & aptDt & "</td>"
          If aptStat = "A001" Then
            response.write "                  <td " & styl & "><div class='datastat pnd'>" & GetComboName("AppointmentType", aptStat) & "</div></td>"
          ElseIf aptStat = "A002" Then
            response.write "                  <td " & styl & "><div class='datastat aprv'>" & GetComboName("AppointmentType", aptStat) & "</div></td>"
          ElseIf aptStat = "A003" Then
            response.write "                  <td " & styl & "><div class='datastat expd'>" & GetComboName("AppointmentType", aptStat) & "</div></td>"
          ElseIf aptStat = "A004" Then
            response.write "                  <td " & styl & "><div class='datastat dnd'>" & GetComboName("AppointmentType", aptStat) & "</div></td>"
          Else
            response.write "                  <td " & styl & "><div class='datastat pnd'>Pending</div></td>"
          End If
          response.write "                </tr>"
          rst.movenext
          response.Flush
        Loop
        response.write "              </tbody>"
        response.write "            </table>"
        response.write "          </div>"
        ' response.write "        </div>"
        response.write "      </div>"
        rst.Close
        Set rst = Nothing
    End If
End Sub

Sub AppointmentSummary()
        
        response.write "<div class=""dashboard"">"
        response.write "    <div id=""total"" class=""tot-pending"">"
        response.write "        <div><i class=""fa-regular fa-square-check""></i></div>"
        response.write "     <div class=""right"">"
        response.write "        <div>" & lol & "</div>"
        response.write "        <div>PENDING</div>"
        response.write "     </div>"
        response.write "    </div>"
        response.write "    <div id=""total"" class=""tot-confirmed"">"
        response.write "    <div><i class=""fa-regular fa-square-check""></i></div>"
        response.write "     <div class=""right"">"
        response.write "    <div>" & gtc & "</div>"
        response.write "        <div>CONFIRMED</div>"
        response.write "     </div>"
        response.write "    </div>"
        response.write "    <div id=""total"" class=""tot-cancelled"">"
        response.write "        <div><i class=""fa-regular fa-square-check""></i></div>"
        response.write "     <div class=""right"">"
        response.write "        <div>" & gtcanc & "</div>"
        response.write "        <div>CANCELLED</div>"
        response.write "     </div>"
        response.write "    </div>"
        response.write "    <div id=""total"" class=""tot-completed"">"
        response.write "        <div><i class=""fa-regular fa-square-check""></i></div>"
        response.write "     <div class=""right"">"
        response.write "        <div>" & gtcompleted & "</div>"
        response.write "        <div>COMPLETED</div>"
        response.write "     </div>"
        response.write "    </div>"
        response.write ""
        response.write "   </div>"
    
End Sub

Function GetNewLink(href, linkText, styles)
    Dim html, defColor

    html = html & "<div class='" & styles & "' style='margin: 5px;' onclick=""openPopup1('" & href & "', 800, 600)"">" & linkText & "</div>"
    GetNewLink = html
End Function

Function GetNewLink1(href, linkText, styles)
    Dim html, defColor

    html = html & "<div class='" & styles & "' style='margin: 5px;' onclick=""openLinkInNew('" & href & "')"">" & linkText & "</div>"
    GetNewLink1 = html
End Function

Function GetDateTimeParts(dt)
    dtParsed = CDate(dt)
    
    dtyrs = Year(dtParsed) ' Year
    dtmth = Right("0" & month(dtParsed), 2) ' Month (zero-padded)
    dtdy = Right("0" & Day(dtParsed), 2) ' Day (zero-padded)
    dtym = Right("0" & Hour(dtParsed), 2) & Right("0" & Minute(dtParsed), 2) ' Time (hours and minutes, zero-padded)

    GetDateTimeParts = Array(dtyrs, dtmth, dtdy, dtym)
End Function

Function ApptCreated(val)
    Dim rst, sql, ot
    ot = False
    Set rst = CreateObject("ADODB.Recordset")
    With rst
        sql = "Select top 1 KeyPrefix from Appointment "
        sql = sql & " Where KeyPrefix = '" & val & "'"
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            ot = True
        End If
        .Close
    End With
    ApptCreated = ot
    Set rst = Nothing
End Function

Function GetCurrWrkmnt(table)
    Dim rst, sql, ot
    ot = False
    Set rst = CreateObject("ADODB.Recordset")
    With rst
        sql = "Select top 1 WorkingMonthID from " & table
        sql = sql & " Order by WorkingMonthID Desc "
        .maxrecords = 1
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            ot = rst.fields("WorkingMonthID")
        End If
        .Close
    End With
    GetCurrWrkmnt = ot
    Set rst = Nothing
End Function

Function GetTotalPending()
    Dim rst, sql, tot
    Set rst = CreateObject("ADODB.Recordset")
    sql = "WITH mytbl AS ("
    sql = sql & " SELECT AppointmentID as RefVal"
    sql = sql & " FROM Appointment WHERE Appointmenttypeid = 'A001'"
    sql = sql & " Union All "
    sql = sql & " SELECT erq.EMRRequestID as RefVal"
    sql = sql & " FROM EMRResults er, Visitation v, EMRRequest erq"
    sql = sql & " Where er.EMRRequestID = erq.EMRRequestID And erq.VisitationID = v.VisitationID"
    sql = sql & " And EMRDataID = 'FNH24001' AND EMRComponentID = 'FNH24001001'"
    sql = sql & " AND erq.EMRRequestID NOT IN (SELECT keyprefix FROM Appointment WHERE keyprefix <> '')"
    sql = sql & "         ) SELECT COUNT(RefVal) FROM mytbl"
    
'        If dat1 <> "" And dat2 <> "" Then
'            mth = ""
'            If dat11 = "" And dat21 = "" Then
'                dat11 = "00:00:00"
'                dat21 = "23:59:59"
'            End If
'            sql = sql & " WHERE Appointdate BETWEEN  '" & dat1 & " " & dat11 & "' AND '" & dat2 & " " & dat21 & "' "
'            sqlWhere = " WHERE Appointdate BETWEEN '" & dat1 & " " & dat11 & "' AND '" & dat2 & " " & dat21 & "' "
'        ElseIf mth <> "" Then
'            dat1 = ""
'            dat2 = ""
'            dat11 = ""
'            dat21 = ""
'            If mth = "All" Then
'                mth = ""
'            End If
'            If mth <> "" Then
'                sql = sql & " WHERE WorkingMonthID = '" & mth & "' "
'                sqlWhere = " WHERE WorkingMonthID = '" & mth & "' "
'            End If
'        Else
'            mth = GetCurrWrkmnt("Visitation")
'            If mth <> "" Then
'                sql = sql & " WHERE WorkingMonthID = '" & mth & "' AND Appointdate > GETDATE() - 1"
'                sqlWhere = " WHERE WorkingMonthID = '" & mth & "' AND Appointdate > GETDATE() - 1 "
'            End If
'        End If
'        If mth = "" And dat1 = "" And dat2 = "" Then
'            WHAD = "WHERE"
'        Else
'            WHAD = "AND"
'        End If
'        If currSto <> "All" And currSto <> "" And SletSto = "" Then
'            sql = sql & " " & WHAD & " SpecialistID = '" & currSto & "' "
'        ElseIf SletSto <> "" Then
'            currSto = ""
'            sql = sql & " " & WHAD & " SpecialistID IN (" & getValuesInString(SletSto) & ")"
'        End If
'        sql = sql & " ORDER By AppointDate "
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            .movefirst
            tot = .fields("totalPending")
            GetTotalPending = tot
        End If
        .Close
    End With
End Function

Function GetTotalConfirmed()
    Dim rst, sql, tot
    Set rst = CreateObject("ADODB.Recordset")
        sql = "SELECT COUNT(Appointmenttypeid) AS TotalConfirmed FROM Appointment WHERE Appointmenttypeid = 'A002'"
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
           .movefirst
           tot = .fields("TotalConfirmed")
           GetTotalConfirmed = tot
        End If
        .Close
    End With
End Function

Function GetTotalCancelled()
    Dim rst, sql, tot
    Set rst = CreateObject("ADODB.Recordset")
        sql = "SELECT COUNT(Appointmenttypeid) AS TotalCancelled FROM Appointment WHERE Appointmenttypeid = 'A003'"
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
           .movefirst
           tot = .fields("TotalCancelled")
           GetTotalCancelled = tot
        End If
        .Close
    End With
End Function
Function GetTotalCompleted()
    Dim rst, sql, tot
    Set rst = CreateObject("ADODB.Recordset")
        sql = "SELECT COUNT(Appointmenttypeid) AS TotalCompleted FROM Appointment WHERE Appointmenttypeid = 'A004'"
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
           .movefirst
           tot = .fields("TotalCompleted")
           GetTotalCompleted = tot
        End If
        .Close
    End With
End Function




Sub getAppointmentData()
    Dim conn, rs, sql
    Set conn = CreateObject("ADODB.Connection")
    conn.open "your_connection_string_here"
    
    sql = "SELECT AppointmenttypeId AS Appointmenttype_ID, COUNT(AppointmenttypeId) AS totalPending FROM Appointment GROUP BY AppointmenttypeId"
    Set rs = conn.execute(sql)

    If Not rs.EOF Then
        Do While Not rs.EOF
            response.write "Appointment Type ID: " & rs("Appointmenttype_ID") & "<br>"
            response.write "Total Pending: " & rs("totalPending") & "<br><br>"
            rs.movenext
        Loop
    Else
        response.write "No appointment data found."
    End If
    rs.Close
    conn.Close
    Set rs = Nothing
    Set conn = Nothing
End Sub




Sub TopHead()

    response.write "  <div class='t-case rlt t-title'>"
    response.write "    <div class='abs min-top df jc cp'>"
    response.write "      <div class='rlt'><div class='abs t-case-i'>Minimize</div></div>"
    response.write "      <i class='fa-solid fa-angle-up icnn'></i>"
    response.write "    </div>"
    response.write "    <div class='cnt'>"
    response.write "      <div class='t-title df fs p10 m15 mlr25 pb0 pt0 dnp'>"
    response.write DetailSelectorFilter("SpecialistID", "Specialist", "Specialist", "spid", currSto)
    response.write DetailSelectorFilter("WorkingMonthID", "Month", "WorkingMonth", "wrkmID", mth)
    response.write "      </div>"
    response.write "      <div class='t-title df fs p10 m15 mlr25 pb0 pt0 dnp'>"
    response.write SelectSelectorFilter("SpecialistID", "Specialists", "Specialist", "spids", SletSto)
    response.write "          <div class='df f1 plr25 mlr25'>"
    response.write DateSelector("Appoint. Date", "dpid", "dpid1", "mw-115", dat1, dat11)
    response.write DateSelector("To", "dp1id", "dp1id1", "", dat2, dat21)
    response.write SubmitButton("Submit", "spids||spid||wrkmID||dpid||dpid1||dp1id||dp1id1")
    response.write "          </div>"
    ' response.write "    <div class='df fs'>"
    ' response.write SubmitButton("Submit", "spids||spid||wrkmID||dpid||dpid1||dp1id||dp1id1")
    ' response.write "    </div>"
    response.write "      </div>"
    response.write "    </div>"
    response.write "  </div>"

End Sub

Function DateSelector(itmName, id, id1, extraClass, value, value1)
    html = " "

    html = html & "     <span class='plr10 t2 " & extraClass & "'>" & itmName & "</span>"
    html = html & "     <input class='select-value1' type='date' value='" & value & "' id='" & id & "'/>"
    html = html & "     <input class='select-value1' type='time' step='60' value='" & value1 & "' id='" & id1 & "'/>"

    DateSelector = html
End Function
    
Function SubmitButton(title, submitIDs)
    html = " "
    
    html = html & " <div class='btsty bs' id='submitButton'>" & title & "</div>" & vbCrLf
    html = html & " <script>" & vbCrLf

    Dim idArray
    idArray = Split(submitIDs, "||")
    For Each id In idArray
        html = html & "    let " & id & " = '" & id & "';" & vbCrLf
    Next
    html = html & "    document.getElementById('submitButton').addEventListener('click', function() {" & vbCrLf
    html = html & "        submitDetails();" & vbCrLf
    html = html & "    });" & vbCrLf
    html = html & "    function submitDetails() {" & vbCrLf
    For Each id In idArray
        html = html & "        const " & id & "Value = document.getElementById('" & id & "').value;" & vbCrLf
    Next
    html = html & "        let currentURL = 'wpgPrtPrintLayoutAll.asp?PrintLayoutName=" & printlayoutName & "&PositionForTableName=WorkingDay';" & vbCrLf
    html = html & "        let newURL = currentURL + '&WorkingDayID=DAY20160401';" & vbCrLf
    For Each id In idArray
        html = html & "        newURL += '&" & id & "=' + " & id & "Value;" & vbCrLf
    Next
    html = html & "        window.location.href = newURL;" & vbCrLf
    html = html & "    }" & vbCrLf
    html = html & " </script>" & vbCrLf

    SubmitButton = html
End Function

Function SelectSelectorFilter(itmID, itmName, table, id, value)
    Dim rst, sql
    Set rst = CreateObject("ADODB.Recordset")
    html = " "

    If UCase(table) = UCase("Specialist") Then
        sql = " SELECT DISTINCT " & itmID
        sql = sql & " FROM ("
        sql = sql & "     SELECT AppointmentID As VisitationID, PatientID, AppointmentID, AppointDate, AppointMonthID AS WorkingMonthID, MedicalStaffID AS SpecialistID"
        sql = sql & "     FROM Appointment "
        sql = sql & "     UNION ALL"
        sql = sql & "     SELECT v.VisitationID, v.PatientID, 'Request' as AppointmentID, CAST(CONVERT(VARCHAR(MAX), er.COLUMN1) AS DATE) AS AppointDate, v.WorkingMonthID, CONVERT(VARCHAR(MAX), er.COLUMN3) AS SpecialistID "
        sql = sql & "     FROM EMRResults er, Visitation v, EMRRequest erq"
        sql = sql & "     WHERE er.EMRRequestID = erq.EMRRequestID AND erq.VisitationID = v.VisitationID"
        sql = sql & "     And EMRDataID = 'FNH24001' AND EMRComponentID = 'FNH24001001'"
        sql = sql & " ) AS data " & sqlWhere
    Else
        sql = " Select DISTINCT " & itmID & " FROM " & table
    End If

    html = html & " <div class='period-selector df f1 plr25 mlr25'>"
    html = html & "     <span class='plr10 t2 mw-115'>" & itmName & "</span>"
    html = html & "     <div class='rlt'>"
    html = html & "     <div class='btsty bss' id='openSelect" & id & "'>Select " & itmName & "</div>"
    html = html & "     <div class='abs slct" & id & " dn' style='z-index: 99;'>"
    html = html & "       <div class='df fc fs cntslt'>"
    html = html & "         <div class='tpslt df sb mb5'>"
    html = html & "             <div class='df p5'>"
    html = html & "             <input type='checkbox' id='selectAll" & id & "'><label for='selectAll" & id & "' class='b600'>Select All</label>"
    html = html & "             </div>"
    html = html & "             <div class='btsty bs m0' id='doneButton" & id & "'>done</div>"
    html = html & "         </div>"
    html = html & "         <div class='df fc fs w100 chcklst" & id & "' style='font-size: 14px;'>"
    rst.open qryPro.FltQry(sql), conn, 3, 4
    If rst.RecordCount > 0 Then
        rst.movefirst
        Do Until rst.EOF
            val = rst.fields("" & itmID & "")
            valName = GetComboName("" & table & "", rst.fields("" & itmID & ""))

            html = html & "             <div class='df p5' onclick=""toggleCheckbox('" & CStr(val) & "')"">"
            If IsValueInList(CStr(val), value) Then
                html = html & "               <input type='checkbox' id='" & CStr(val) & "' value='" & CStr(val) & "' checked><label for='" & CStr(val) & "'>" & valName & "</label>"
            Else
                html = html & "               <input type='checkbox' id='" & CStr(val) & "' value='" & CStr(val) & "'><label for='" & CStr(val) & "'>" & valName & "</label>"
            End If
            html = html & "             </div>"
                
            rst.movenext
            html = html & response.Flush
        Loop
    End If

    html = html & "         </div>"
    html = html & "       </div>"
    html = html & "     </div>"
    html = html & "     </div>"
    html = html & "     <input id='" & id & "' type='text' class='select-value1 dn' value=''>"
    html = html & "     <span id='selectedCount" & id & "' class='b600' style='font-size: 13px;'></span>"
    html = html & " </div>"

    html = html & " <script>"
    html = html & " var doneButton" & id & " = document.getElementById('doneButton" & id & "');"
    html = html & " var openSelect" & id & " = document.getElementById('openSelect" & id & "');"
    html = html & " var slct" & id & " = document.querySelector('.slct" & id & "');"
    html = html & " var selectedOpt" & id & " = document.getElementById('" & id & "');"
    html = html & " var selectedCntEl" & id & "  = document.getElementById('selectedCount" & id & "');"
    html = html & " var selectAllCheckbox" & id & " = document.getElementById('selectAll" & id & "');"
    html = html & " var otherCheckboxes" & id & " = document.querySelectorAll('.chcklst" & id & " input[type=""checkbox""]:not(#selectAll" & id & ")');"
    html = html & " openSelect" & id & ".addEventListener('click', ()=>{"
    html = html & "     slct" & id & ".classList.remove('dn');"
    html = html & " });"
    html = html & " function countChecked() {"
    html = html & "     let checkedCount = 0;"
    html = html & "     otherCheckboxes" & id & ".forEach(function (checkbox) {"
    html = html & "         if (checkbox.checked) {"
    html = html & "             checkedCount++;"
    html = html & "         }"
    html = html & "     });"
    html = html & "     return checkedCount;"
    html = html & " }"
    html = html & " var initialCheckedCount" & id & " = countChecked();"
    html = html & " selectedCntEl" & id & ".textContent = initialCheckedCount" & id & " + ' Sponsors Selected';"
    html = html & " doneButton" & id & ".addEventListener('click', function () {"
    html = html & "     let " & id & " = [];"
    html = html & "     let selectedCount" & id & " = 0;"
    html = html & "     otherCheckboxes" & id & ".forEach(function (checkbox) {"
    html = html & "         if (checkbox.checked) {"
    html = html & "             " & id & ".push(checkbox.value);"
    html = html & "             selectedCount" & id & "++;"
    html = html & "         }"
    html = html & "     });"
    html = html & "     slct" & id & ".classList.add('dn');"
    html = html & "     selectedOpt" & id & ".value = " & id & ".join('||');"
    html = html & "     selectedCntEl" & id & ".textContent = selectedCount" & id & " + ' Sponsors Selected';"
    html = html & " });"
    html = html & " selectAllCheckbox" & id & ".addEventListener('change', function () {"
    html = html & "     otherCheckboxes" & id & ".forEach(function (checkbox) {"
    html = html & "         checkbox.checked = selectAllCheckbox" & id & ".checked;"
    html = html & "     });"
    html = html & " });"
    html = html & " function toggleCheckbox(checkboxId) {"
    html = html & "     var checkbox = document.getElementById(checkboxId);"
    html = html & "     checkbox.checked = !checkbox.checked;"
    html = html & " }"
    html = html & " </script>"

    rst.Close
    Set rst = Nothing
    SelectSelectorFilter = html
End Function

Function getValuesInString(splst)
    Dim idArray
    idArray = Split(splst, "||")
    Dim result
    result = "'" & Join(idArray, "', '") & "'"
    getValuesInString = result
End Function

Function IsValueInList(value, list)
    Dim idArray
    idArray = Split(list, "||")
    Dim item
    For Each item In idArray
        If Trim(item) = Trim(value) Then
            IsValueInList = True
            Exit Function
        End If
    Next
    IsValueInList = False
End Function

Function DetailSelectorFilter(itmID, itmName, table, id, value)
    Dim rst, sql
    Set rst = CreateObject("ADODB.Recordset")
    html = " "

    If UCase(table) = UCase("WorkingMonth") Then
        sql = " Select DISTINCT " & itmID & " FROM " & table & " Order by " & itmID & " Desc "
    ElseIf UCase(table) = UCase("Specialist") Then
        sql = " SELECT DISTINCT " & itmID
        sql = sql & " FROM ("
        sql = sql & "     SELECT AppointmentID As VisitationID, PatientID, AppointmentID, AppointDate, AppointMonthID AS WorkingMonthID, MedicalStaffID AS SpecialistID"
        sql = sql & "     FROM Appointment "
        sql = sql & "     UNION ALL"
        sql = sql & "     SELECT v.VisitationID, v.PatientID, 'Request' as AppointmentID, CAST(CONVERT(VARCHAR(MAX), er.COLUMN1) AS DATE) AS AppointDate, v.WorkingMonthID, CONVERT(VARCHAR(MAX), er.COLUMN3) AS SpecialistID "
        sql = sql & "     FROM EMRResults er, Visitation v, EMRRequest erq"
        sql = sql & "     WHERE er.EMRRequestID = erq.EMRRequestID AND erq.VisitationID = v.VisitationID"
        sql = sql & "     And EMRDataID = 'FNH24001' AND EMRComponentID = 'FNH24001001'"
        sql = sql & " ) AS data " & sqlWhere
    Else
        sql = " Select DISTINCT " & itmID & " FROM " & table
    End If

    html = html & " <div class='period-selector df f1 plr25 mlr25'> "
    html = html & "     <span class='plr10 t2 mw-115'>" & itmName & "</span>"
    html = html & "     <input class='select-value1' type='text' id='filterInput" & id & "' placeholder='" & itmName & "' />"
    html = html & "     <select id='" & id & "' class='select-value1'>"
    html = html & "       <option value=''></option>"
    If UCase(value) = UCase("All") Then
        html = html & "       <option value='All' selected>All " & itmName & "s</option>"
    Else
        html = html & "       <option value='All'>All " & itmName & "s</option>"
    End If
    
    rst.open qryPro.FltQry(sql), conn, 3, 4
    If rst.RecordCount > 0 Then
        rst.movefirst
        Do Until rst.EOF
            val = rst.fields("" & itmID & "")
            valName = GetComboName("" & table & "", rst.fields("" & itmID & ""))

            If UCase(CStr(val)) = UCase(value) Then
                html = html & "         <option class='opt-sty' value='" & CStr(val) & "' id='" & CStr(val) & "' selected >" & valName & "</option>"
            Else
                html = html & "         <option class='opt-sty' value='" & CStr(val) & "' id='" & CStr(val) & "'>" & valName & "</option>"
            End If
                
            rst.movenext
            html = html & response.Flush
        Loop
    End If
    
    html = html & "     </select>"

    html = html & " <script>" & vbCrLf
    html = html & "   var filterInput" & id & " = document.getElementById('filterInput" & id & "');"
    html = html & "   var filterDropdown" & id & " = document.getElementById('" & id & "');"
    html = html & "   filterInput" & id & ".addEventListener('input', function () {"
    html = html & "     var filterValue = filterInput" & id & ".value.toLowerCase();"
    html = html & "     for (var i = 0; i < filterDropdown" & id & ".options.length; i++) {"
    html = html & "       var optionText = filterDropdown" & id & ".options[i].text.toLowerCase();"
    html = html & "       var optionValue = filterDropdown" & id & ".options[i].value.toLowerCase();"
    html = html & "       if ("
    html = html & "         optionText.includes(filterValue) ||"
    html = html & "         optionValue.includes(filterValue)"
    html = html & "       ) {"
    html = html & "         filterDropdown" & id & ".selectedIndex = i;"
    html = html & "         break;"
    html = html & "       }"
    html = html & "     }"
    html = html & "   });"
    html = html & "</script>" & vbCrLf
    html = html & " </div>"

    rst.Close
    Set rst = Nothing
    DetailSelectorFilter = html
End Function

Sub TableEX()

    response.write "        <div class='p15 df dnp pt0'>"
    ' response.write "          <button id='exportCSV' class='btsty bs'>"
    ' response.write "            <span>Export To CSV &nbsp;</span>"
    ' response.write "            <i class='fa-solid fa-file-csv'></i>"
    ' response.write "          </button>"
    response.write "          <button onclick=""exportExcel('tbl');"" class='btsty bs'>"
    response.write "            <span>Export To Excel &nbsp;</span>"
    response.write "            <i class='fa-solid fa-file-excel'></i>"
    response.write "          </button>"
    response.write "          <button onclick='window.print();' class='btsty bs'>"
    response.write "            <span>Print Table &nbsp;</span>"
    response.write "            <i class='fa-solid fa-print'></i>"
    response.write "          </button>"
    response.write "        <div class='df f1 plr25 mlr25'>"
    response.write "          <div class='t2 plr10'>Search Table</div>"
    response.write "          <input class='select-value1' type='text' id='searchInput' placeholder='search..'/>"
    response.write "        </div>"
    response.write "        </div>"

End Sub
     
Sub StylesAdded()

    response.write "     <style>"
    response.write "       :root {"
    response.write "         --bc: white;"
    response.write "         --bp: #0994de;"
    response.write "         --br: #ffd54a;"
    response.write "         --brhv: #ffc400;"
    response.write "         --bphv: #087ab8;"
    response.write "         --bss: #05ab5d;"
    response.write "         --bsshv: #198754;"
    response.write "         --bwrn: #ff3f52;"
    response.write "         --bwrnhv: #dc3545;"
    response.write "         --bs: #939393;"
    response.write "         --bshv: #6c757d;"
    response.write "         --bsty-primary: #005f92;"
    response.write "         --bsty-alert: #dc3545;"
    response.write "         --bsty-alert-hover: #ff6776;"
    response.write "         --bsty-primary-hover: #0994de;"
    response.write "         --bsty-success: #198754;"
    response.write "         --bsty-success-hover: #05ab5d;"
    response.write "         --bsty-sec: #ffc400;"
    response.write "         --bsty-sec-hover: #ffd54a;"
    response.write "       }"
    response.write "       .holder {"
    response.write "         display: flex;"
    response.write "       }"
    response.write "       .btsty {"
    response.write "         width: fit-content;"
    response.write "         padding: 4px;"
    response.write "         margin: 0px 0px 0px 5px;"
    response.write "         border-radius: 4px;"
    response.write "         cursor: pointer;"
    response.write "         text-align: center;"
    response.write "         white-space: nowrap;"
    response.write "         border: none;"
    response.write "         font-size: 13.33px;"
    response.write "         text-decoration: none;"
    response.write "       }"
    response.write "       .pm {"
    response.write "         color: var(--bsty-primary);"
    response.write "       }"
    response.write "       .pm:hover {"
    response.write "         text-decoration: underline;"
    response.write "         color: var(--bsty-primary-hover);"
    response.write "       }"
    response.write "       .rd {"
    response.write "         color: var(--bsty-sec);"
    response.write "       }"
    response.write "       .rd:hover {"
    response.write "         text-decoration: underline;"
    response.write "         color: var(--bsty-sec-hover);"
    response.write "       }"
    response.write "       .bnm:hover {"
    response.write "         text-decoration: underline;"
    response.write "       }"
    response.write "       .wrn {"
    response.write "         color: var(--bsty-alert);"
    response.write "       }"
    response.write "       .wrn:hover {"
    response.write "         color: var(--bsty-alert-hover);"
    response.write "         text-decoration: underline;"
    response.write "       }"
    response.write "       .scc {"
    response.write "         color: var(--bsty-success);"
    response.write "       }"
    response.write "       .scc:hover {"
    response.write "         color: var(--bsty-success-hover);"
    response.write "         text-decoration: underline;"
    response.write "       }"
    response.write "       .bp {"
    response.write "         background-color: var(--bp);"
    response.write "         color: var(--bc);"
    response.write "         margin: 0px 5px 0px 5px;"
    response.write "         padding: 4px 12px;"
    response.write "       }"
    response.write "       .br {"
    response.write "         background-color: var(--br);"
    response.write "         color: var(--bc);"
    response.write "         margin: 0px 5px 0px 5px;"
    response.write "         padding: 4px 12px;"
    response.write "       }"
    response.write "       .obp {"
    response.write "         box-shadow: 0px 0px 1px 1px var(--bp);"
    response.write "         color: var(--bphv);"
    response.write "         margin: 0px 5px 0px 5px;"
    response.write "         padding: 4px 12px;"
    response.write "       }"
    response.write "       .obp:hover {"
    response.write "         background-color: var(--bp);"
    response.write "         color: var(--bc);"
    response.write "       }"
    response.write "       .bp:hover {"
    response.write "         background-color: var(--bphv);"
    response.write "       }"
    response.write "       .bss {"
    response.write "         background-color: var(--bss);"
    response.write "         color: var(--bc);"
    response.write "         margin: 0px 5px 0px 5px;"
    response.write "         padding: 4px 12px;"
    response.write "       }"
    response.write "       .obss {"
    response.write "         box-shadow: 0px 0px 1px 1px var(--bss);"
    response.write "         color: var(--bsshv);"
    response.write "         margin: 0px 5px 0px 5px;"
    response.write "         padding: 4px 12px;"
    response.write "       }"
    response.write "       .obss:hover {"
    response.write "         background-color: var(--bss);"
    response.write "         color: var(--bc);"
    response.write "       }"
    response.write "       .bss:hover {"
    response.write "         background-color: var(--bsshv);"
    response.write "       }"
    response.write "       .br:hover {"
    response.write "         background-color: var(--brhv);"
    response.write "       }"
    response.write "       .bwrn {"
    response.write "         background-color: var(--bwrn);"
    response.write "         color: var(--bc);"
    response.write "         margin: 0px 5px 0px 5px;"
    response.write "         padding: 4px 12px;"
    response.write "       }"
    response.write "       .obwrn {"
    response.write "         box-shadow: 0px 0px 1px 1px var(--bwrn);"
    response.write "         color: var(--bwrnhv);"
    response.write "         margin: 0px 5px 0px 5px;"
    response.write "         padding: 4px 12px;"
    response.write "       }"
    response.write "       .obwrn:hover {"
    response.write "         background-color: var(--bwrn);"
    response.write "         color: var(--bc);"
    response.write "       }"
    response.write "       .bwrn:hover {"
    response.write "         background-color: var(--bwrnhv);"
    response.write "       }"
    response.write "       .bs {"
    response.write "         background-color: var(--bs);"
    response.write "         color: var(--bc);"
    response.write "         margin: 0px 5px 0px 5px;"
    response.write "         padding: 4px 12px;"
    response.write "       }"
    response.write "       .obs {"
    response.write "         box-shadow: 0px 0px 1px 1px var(--bs);"
    response.write "         color: var(--bshv);"
    response.write "         margin: 0px 5px 0px 5px;"
    response.write "         padding: 4px 12px;"
    response.write "       }"
    response.write "       .obs:hover {"
    response.write "         background-color: var(--bshv);"
    response.write "         color: var(--bc);"
    response.write "       }"
    response.write "       .bs:hover {"
    response.write "         background-color: var(--bshv);"
    response.write "       }"
    response.write "       .bold {"
    response.write "         font-weight: 600;"
    response.write "       }"
    response.write "       .aln {"
    response.write "         padding: 0px;"
    response.write "         margin: 0px;"
    response.write "       }"
    response.write "       .f-end {"
    response.write "         justify-content: flex-end;"
    response.write "       }"
    response.write "       .alf-end {"
    response.write "         align-items: flex-end;"
    response.write "       }"
    response.write "       .table-holder::-webkit-scrollbar {"
    response.write "         width: 5px;"
    response.write "         height: 5px;"
    response.write "       }"
    response.write "       .table-holder::-webkit-scrollbar-track {"
    response.write "         background: #efefef;"
    response.write "       }"
    response.write "       .table-holder::-webkit-scrollbar-thumb {"
    response.write "         background: #b4b4b4;"
    response.write "       }"
    response.write "       .table-holder::-webkit-scrollbar-thumb:hover {"
    response.write "         background: #888;"
    response.write "       }"
    response.write "       .table-holder::-webkit-scrollbar-button:hover {"
    response.write "         background: #888;"
    response.write "       }"
    response.write "       .tbl {"
    response.write "         width: 100%;"
    response.write "         border-collapse: collapse;"
    response.write "       }"
    response.write "       .tbl1 {"
    response.write "         width: 100%;"
    response.write "         border-collapse: collapse;"
    response.write "       }"
    response.write "       .fh {"
    response.write "         padding: 7px 16px;"
    response.write "         font-size: 12px;"
    response.write "         position: sticky;"
    response.write "         top: 0;"
    response.write "         z-index: 9;"
    response.write "         background-color: #f9fafb;"
    response.write "       }"
    response.write "       .fh-s {"
    response.write "         padding: 7px 16px;"
    response.write "         font-size: 12px;"
    response.write "         position: sticky;"
    response.write "         top: 0;"
    response.write "         z-index: 9;"
    response.write "       }"
    response.write "       .tbl-b tr:first-child td {"
    response.write "         border-top: 1px solid #ddd;"
    response.write "       }"
    ' response.write "       .tbl-Sub tr td:first-child {"
    ' response.write "         border-left: 1px solid #ddd;"
    ' response.write "       }"
    response.write "       .tbl-Sub tr td {"
    response.write "         padding: 5px !important;"
    response.write "         font-size: 13px !important;"
    response.write "         background: none;"
    response.write "       }"
    ' response.write "       .tbl-Sub tr td:last-child {"
    ' response.write "         border-right: 1px solid #ddd;"
    ' response.write "       }"
    response.write "       .tbl-Sub tr th {"
    response.write "         font-size: 12px;"
    response.write "         padding: 5px 10px;"
    response.write "       }"
    response.write "       .tbl-b tr:last-child td {"
    response.write "         border-bottom: none;"
    response.write "       }"
    response.write "       .tbl-b tr:last-child td:first-child {"
    response.write "         border-bottom-left-radius: 8px;"
    response.write "       }"
    response.write "       .tbl-b tr:last-child td:last-child {"
    response.write "         border-bottom-right-radius: 8px;"
    response.write "       }"
    response.write "       .tbl-h tr:first-child th:first-child {"
    response.write "         border-top-left-radius: 8px;"
    response.write "       }"
    response.write "       .tbl-h tr:first-child th:last-child {"
    response.write "         border-top-right-radius: 8px;"
    response.write "       }" 'tbl-Sub
    response.write "       .tbl-b tr td {"
    response.write "         padding: 10px 8px;"
    response.write "         border-bottom: 1px solid #ddd;"
    response.write "         background-color: white;"
    response.write "         font-size: 14px;"
    response.write "         vertical-align: top;"
    response.write "       }"
    response.write "       .tbl1 tbody tr td {"
    response.write "         padding: 0px;"
    response.write "         border: none !important;"
    response.write "         background-color: white;"
    response.write "         font-size: 14px;"
    response.write "       }"
    response.write "     .tbl1 {"
    response.write "       border-collapse: separate;"
    response.write "       border-spacing: 0;"
    response.write "       width: 100%;"
    response.write "     }"
    response.write "     .fh1 {"
    response.write "       padding: 6px 12px;"
    response.write "       font-size: 12px;"
    response.write "       position: sticky;"
    response.write "       top: 0;"
    response.write "       z-index: 9;"
    response.write "       background-color: #ececec;"
    response.write "     }"
    response.write "     .fhn {"
    response.write "       font-size: 10px;"
    response.write "     }"
    response.write "     .tbl-b1 tr td {"
    response.write "       padding: 8px 12px;"
    response.write "       border-bottom: 1px solid #ddd;"
    response.write "       background-color: white;"
    response.write "       font-size: 14px;"
    response.write "     }"
    response.write "     .tbl-b1 tr:hover td {"
    response.write "       background-color: #f9fafb;"
    response.write "     }"
    response.write "     .tbl-b1-b tr td {"
    response.write "       padding: 8px 12px;"
    response.write "       border-bottom: 1px solid #ddd;"
    response.write "       background-color: white;"
    response.write "       font-size: 14px;"
    response.write "     }"
    response.write "     .tbl-b1-b tr:hover td {"
    response.write "       background-color: #f9fafb;"
    response.write "     }"
    response.write "     .tbl-h1 tr:first-child th:first-child {"
    response.write "       border-top-left-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-h1 tr:first-child th:last-child {"
    response.write "       border-top-right-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-h1 tr:first-child th:first-child {"
    response.write "       border-bottom-left-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-h1 tr:first-child th:last-child {"
    response.write "       border-bottom-right-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-b1 tr:first-child td {"
    response.write "       border-top: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-b1 tr td:first-child {"
    response.write "       border-left: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-b1 tr td:last-child {"
    response.write "       border-right: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-b1-b tr:first-child td {"
    response.write "       border-top: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-b1-b tr td:first-child {"
    response.write "       border-left: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-b1-b tr td:last-child {"
    response.write "       border-right: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-b1 tr:first-child td:first-child {"
    response.write "       border-top-left-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-b1 tr:first-child td:last-child {"
    response.write "       border-top-right-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-b1 tr:last-child td:first-child {"
    response.write "       border-bottom-left-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-b1 tr:last-child td:last-child {"
    response.write "       border-bottom-right-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-b1-b tr:first-child td:first-child {"
    response.write "       border-top-left-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-b1-b tr:first-child td:last-child {"
    response.write "       border-top-right-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-b1-b tr:last-child td:first-child {"
    response.write "       border-bottom-left-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-b1-b tr:last-child td:last-child {"
    response.write "       border-bottom-right-radius: 8px;"
    response.write "     }"
    response.write "     .tbl-b1-b tr td:not(:last-child) {"
    response.write "       border-right: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl2 {"
    response.write "       border-collapse: separate;"
    response.write "       border-spacing: 0px 10px;"
    response.write "       width: 100%;"
    response.write "     }"
    response.write "     .fh2 {"
    response.write "       padding: 6px 12px;"
    response.write "       font-size: 12px;"
    response.write "       position: sticky;"
    response.write "       top: 0;"
    response.write "       z-index: 9;"
    response.write "       background-color: #bbe3eb;"
    response.write "     }"
    response.write "     .tbl-b2 tr td {"
    response.write "       padding: 8px 12px;"
    response.write "       background-color: white;"
    response.write "       font-size: 14px;"
    response.write "     }"
    response.write "     .tbl-b2 tr {"
    response.write "       box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);"
    response.write "     }"
    response.write "     .tbl-b2 tr:hover td {"
    response.write "       background-color: #f9fafb;"
    response.write "     }"
    response.write "     .tbls {"
    response.write "       border-collapse: collapse;"
    response.write "       width: 100%;"
    response.write "     }"
    response.write "     .fhs {"
    response.write "       padding: 6px 12px;"
    response.write "       font-size: 12px;"
    response.write "       position: sticky;"
    response.write "       top: 0;"
    response.write "       z-index: 9;"
    response.write "       background-color: #ececec;"
    response.write "       border-top: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-hs tr th:first-child {"
    response.write "       border-left: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-hs tr th:last-child {"
    response.write "       border-right: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-bs tr td {"
    response.write "       padding: 8px 12px;"
    response.write "       border-bottom: 1px solid #ddd;"
    response.write "       background-color: white;"
    response.write "       font-size: 14px;"
    response.write "     }"
    response.write "     .tbl-bs-b tr td {"
    response.write "       padding: 8px 12px;"
    response.write "       border-bottom: 1px solid #ddd;"
    response.write "       background-color: white;"
    response.write "       font-size: 14px;"
    response.write "     }"
    response.write "     .tbl-bs tr:hover td {"
    response.write "       background-color: #f9fafb;"
    response.write "     }"
    response.write "     .tbl-bs tr td:first-child {"
    response.write "       border-left: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-bs tr td:last-child {"
    response.write "       border-right: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-bs tr:first-child td {"
    response.write "       border-top: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-bs-b tr:hover td {"
    response.write "       background-color: #f9fafb;"
    response.write "     }"
    response.write "     .tbl-bs-b tr td:first-child {"
    response.write "       border-left: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-bs-b tr td:last-child {"
    response.write "       border-right: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-bs-b tr:first-child td {"
    response.write "       border-top: 1px solid #ddd;"
    response.write "     }"
    response.write "     .tbl-bs-b tr td:not(:last-child) {"
    response.write "       border-right: 1px solid #ddd;"
    response.write "     }"
    response.write "       .tbl-main {"
    response.write "         border: 1px solid #ddd;"
    response.write "         border-radius: 8px;"
    response.write "       }"
    response.write "       .main-content {"
    response.write "         height: calc(100% - 80px);"
    response.write "         overflow: auto;"
    response.write "         padding-bottom: 20px;"
    response.write "         background-color: #f9fafb;"
    response.write "       }"
    response.write "       .Select-name {"
    response.write "         font-size: 24px;"
    response.write "         font-weight: 600;"
    response.write "       }"
    response.write "       .datastat {"
    response.write "         font-size: 12px;"
    response.write "         width: fit-content;"
    response.write "         padding: 3px 8px;"
    response.write "         border-radius: 8px;"
    response.write "         white-space: nowrap;"
    response.write "       }"
    response.write "     </style>"
    response.write "     <style>"
    response.write "       * {"
    response.write "         margin: 0;"
    response.write "         padding: 0;"
    response.write "         font-family: 'Segoe UI';"
    response.write "       }"
    response.write "       body {"
    response.write "         background-color: #f9fafb;"
    response.write "       }"
    response.write "       .df {"
    response.write "         display: flex;"
    response.write "         align-items: center;"
    response.write "       }"
    response.write "       .rlt {"
    response.write "         position: relative;"
    response.write "       }"
    response.write "       .abs {"
    response.write "         position: absolute;"
    response.write "       }"
    response.write "       .clsbtt {"
    response.write "         top: -28px;"
    response.write "         right: 0;"
    response.write "       }"
    response.write "       .fs {"
    response.write "         align-items: flex-start;"
    response.write "       }"
    response.write "       .fc {"
    response.write "         flex-direction: column;"
    response.write "       }"
    response.write "       .sb {"
    response.write "         justify-content: space-between;"
    response.write "       }"
    response.write "       .jc {"
    response.write "         justify-content: center;"
    response.write "       }"
    response.write "       .j-sb {"
    response.write "         justify-content: space-between;"
    response.write "       }"
    response.write "       .f1 {"
    response.write "         flex: 1;"
    response.write "       }"
    response.write "       .h100 {"
    response.write "         height: 100%;"
    response.write "       }"
    response.write "       .cp {"
    response.write "         cursor: pointer;"
    response.write "       }"
    response.write "       .p10 {"
    response.write "         padding: 10px;"
    response.write "       }"
    response.write "       .plr5 {"
    response.write "         padding-inline: 5px;"
    response.write "       }"
    response.write "       .plr10 {"
    response.write "         padding-inline: 10px;"
    response.write "       }"
    response.write "       .plr15 {"
    response.write "         padding-inline: 15px;"
    response.write "       }"
    response.write "       .plr25 {"
    response.write "         padding-inline: 25px;"
    response.write "       }"
    response.write "       .p15 {"
    response.write "         padding: 15px;"
    response.write "       }"
    response.write "       .p25 {"
    response.write "         padding: 25px;"
    response.write "       }"
    response.write "       .pb10 {"
    response.write "         padding-bottom: 10px;"
    response.write "       }"
    response.write "       .pb15 {"
    response.write "         padding-bottom: 15px;"
    response.write "       }"
    response.write "       .pb25 {"
    response.write "         padding-bottom: 25px;"
    response.write "       }"
    response.write "       .pt10 {"
    response.write "         padding-top: 10px;"
    response.write "       }"
    response.write "       .pt15 {"
    response.write "         padding-top: 15px;"
    response.write "       }"
    response.write "       .pt25 {"
    response.write "         padding-top: 25px;"
    response.write "       }"
    response.write "       .m10 {"
    response.write "         margin: 10px;"
    response.write "       }"
    response.write "       .mlr10 {"
    response.write "         margin-inline: 10px;"
    response.write "       }"
    response.write "       .mlr15 {"
    response.write "         margin-inline: 15px;"
    response.write "       }"
    response.write "       .mlr25 {"
    response.write "         margin-inline: 25px;"
    response.write "       }"
    response.write "       .m15 {"
    response.write "         margin: 15px;"
    response.write "       }"
    response.write "       .m25 {"
    response.write "         margin: 25px;"
    response.write "       }"
    response.write "       .w100 {"
    response.write "         width: 100%;"
    response.write "       }"
    response.write "       .t1 {"
    response.write "         font-size: 18px;"
    response.write "         font-weight: 600;"
    response.write "       }"
    response.write "       .st1 {"
    response.write "         font-size: 16px;"
    response.write "       }"
    response.write "       .sblg {"
    response.write "         width: 185px;"
    response.write "       }"
    response.write "       .st1s {"
    response.write "         font-size: 15px;"
    response.write "         color: #a1a0a0;"
    response.write "       }"
    response.write "       .t2 {"
    response.write "         font-size: 16px;"
    response.write "         font-weight: 500;"
    response.write "       }"
    response.write "       .t3 {"
    response.write "         font-size: 16px;"
    response.write "         font-weight: 400;"
    response.write "       }"
    response.write "       .st2 {"
    response.write "         font-size: 14px;"
    response.write "       }"
    response.write "       .st3 {"
    response.write "         font-size: 14px;"
    response.write "         font-weight: 300;"
    response.write "       }"
    response.write "       .st2s {"
    response.write "         font-size: 13px;"
    response.write "         color: #a1a0a0;"
    response.write "       }"
    response.write "       .st3s {"
    response.write "         font-size: 13px;"
    response.write "         color: #a1a0a0;"
    response.write "         font-weight: 300;"
    response.write "       }"
    response.write "       .aprv {"
    response.write "         background-color: #def7ec;"
    response.write "         font-weight: 600;"
    response.write "         color: #046c4e;"
    response.write "       }"
    response.write "       .dnd {"
    response.write "         background-color: #fde8e8;"
    response.write "         font-weight: 600;"
    response.write "         color: #c01e1e;"
    response.write "       }"
    response.write "       .pnd {"
    response.write "         background-color: #feecdc;"
    response.write "         font-weight: 600;"
    response.write "         color: #b43403;"
    response.write "       }"
    response.write "       .expd {"
    response.write "         background-color: #f4f5f7;"
    response.write "         font-weight: 600;"
    response.write "         color: #24262d;"
    response.write "       }"
    response.write "       .c-aprv {"
    response.write "         color: #046c4e;"
    response.write "       }"
    response.write "       .c-dnd {"
    response.write "         color: #c01e1e;"
    response.write "       }"
    response.write "       .c-pnd {"
    response.write "         color: #dd761b;"
    response.write "       }"
    response.write "       .c-expd {"
    response.write "         color: #24262d;"
    response.write "       }"
    response.write "       .icn {"
    response.write "         width: 45px;"
    response.write "         height: 45px;"
    response.write "         border-radius: 50%;"
    response.write "         font-size: 20px;"
    response.write "       }"
    response.write "       .top-dt {"
    response.write "         border: 1px solid #ddd;"
    response.write "         border-radius: 8px;"
    response.write "         background-color: white;"
    response.write "       }"
    response.write "       .tbl-b1 tr:first-child td {"
    response.write "         border-top: 1px solid #ddd;"
    response.write "       }"
    response.write "       .tbl-b1 tr:last-child td {"
    response.write "         border-bottom: none;"
    response.write "       }"
    response.write "       .tbl-b1 tr:last-child td:first-child {"
    response.write "         border-bottom-left-radius: 8px;"
    response.write "       }"
    response.write "       .tbl-b1 tr:last-child td:last-child {"
    response.write "         border-bottom-right-radius: 8px;"
    response.write "       }"
    response.write "       .tbl-b1 tr td {"
    response.write "         padding: 12px 16px;"
    response.write "         border-bottom: 1px solid #ddd;"
    response.write "         background-color: white;"
    response.write "         font-size: 14px;"
    response.write "         vertical-align: top;"
    response.write "       }"
    response.write "       .p0 {"
    response.write "         padding: 0px !important;"
    response.write "       }"
    response.write "       .pt0 {"
    response.write "         padding-top: 0px !important;"
    response.write "       }"
    response.write "       .pr0 {"
    response.write "         padding-right: 0px !important;"
    response.write "       }"
    response.write "       .pr5 {"
    response.write "         padding-right: 5px !important;"
    response.write "       }"
    response.write "       .pl0 {"
    response.write "         padding-left: 0px !important;"
    response.write "       }"
    response.write "       .pb0 {"
    response.write "         padding-bottom: 0px !important;"
    response.write "       }"
    response.write "       td .p5 {"
    response.write "         padding: 5px !important;"
    response.write "       }"
    response.write "       .fh1 {"
    response.write "         padding: 5px 10px;"
    response.write "         font-size: 12px;"
    response.write "         background-color: #f9fafb;"
    response.write "       }"
    response.write "       .meal-tbl tr td {"
    response.write "         padding: 2px;"
    response.write "       }"
    response.write "       .meal-hld {"
    response.write "         flex-grow: 1;"
    response.write "       }"
    response.write "       .meal-hld:first-child {"
    response.write "         background-color: #fff6b689;"
    response.write "       }"
    response.write "       .meal-hld:nth-child(2) {"
    response.write "         background-color: #ffdcb686;"
    response.write "       }"
    response.write "       .meal-hld:last-child {"
    response.write "         background-color: #ffc6b689;"
    response.write "       }"
    response.write "       .meal-hld:first-child {"
    response.write "         border-bottom-left-radius: 8px;"
    response.write "         border-top-left-radius: 8px;"
    response.write "       }"
    response.write "       .meal-hld:last-child {"
    response.write "         border-bottom-right-radius: 8px;"
    response.write "         border-top-right-radius: 8px;"
    response.write "       }"
    response.write "       .menu {"
    response.write "         background-color: white;"
    response.write "         align-items: stretch;"
    response.write "         width: fit-content;"
    response.write "         border-radius: 8px;"
    response.write "         box-shadow: 0px 0px 3px 1px #ddd;"
    response.write "       }"
    response.write "       .opt-sty {"
    response.write "         font-size: 12px;"
    response.write "         background: #eeeeee;"
    response.write "       }"
    response.write " .select-value1 {"
    response.write "   padding-inline: 8px;"
    response.write "   padding-top: 4px;"
    response.write "   padding-bottom: 4px;"
    response.write "   font-size: 12px !important;"
    ' response.Write "   display: block;"
    response.write "   box-sizing: border-box;"
    response.write "   border-radius: 4px;"
    response.write "   border: 1px solid #dddddd;"
    response.write "   outline: none;"
    response.write "   background: #f8f8f8;"
    response.write "   transition: background 0.2s, border-color 0.2s;"
    ' response.Write "   max-width: 16%;"
    response.write "   min-width: 16%;"
    response.write "   text-align: left;"
    response.write " }"
    response.write " .select-value1:focus {"
    response.write "   border-color: #a8d9e4;"
    response.write "   background: #ffffff;"
    response.write " }"
    response.write "  .pt0 {"
    response.write "    padding-top: 0px !important;"
    response.write "  }"
    response.write "  .pr0 {"
    response.write "    padding-right: 0px !important;"
    response.write "  }"
    response.write "  .pl0 {"
    response.write "    padding-left: 0px !important;"
    response.write "  }"
    response.write "  .pb0 {"
    response.write "    padding-bottom: 0px !important;"
    response.write "  }"
    response.write "  td .p5 {"
    response.write "    padding: 5px !important;"
    response.write "  }"
    response.write "  .p5 {"
    response.write "    padding: 5px !important;"
    response.write "  }"
    response.write "  .fh1 {"
    response.write "    padding: 5px 10px;"
    response.write "    font-size: 12px;"
    response.write "    background-color: #f9fafb;"
    response.write "  }"
    response.write "  .dn {"
    response.write "    display: none !important;"
    response.write "    border: none !important;"
    response.write "  }"
    response.write " .custom-tooltip {"
    response.write "   position: relative;"
    response.write "   display: inline-block;"
    response.write "   cursor: pointer;"
    response.write " }"
    response.write " .tooltip-text {"
    response.write "   display: none;"
    response.write "   position: absolute;"
    response.write "   left: 10px;"
    response.write "   background-color: #afafaf;"
    response.write "   color: #fff;"
    response.write "   padding: 5px;"
    response.write "   border-radius: 6px;"
    response.write " }"
    response.write " .p24 {"
    response.write "   padding: 2px 4px;"
    response.write " }"
    response.write "       .tbl-b tr:hover td {"
    response.write "         background-color: #fafafa;"
    response.write "       }"
    ' response.Write "        th[data-sort='asc']::after {"
    ' response.Write "           content: ' ?';"
    ' response.Write "           font-size: 12px;"
    ' response.Write "           line-height: 1;"
    ' response.Write "         }"
    ' response.Write "         th[data-sort='desc']::after {"
    ' response.Write "           content: ' ?';"
    ' response.Write "           font-size: 12px;"
    ' response.Write "           line-height: 1;"
    ' response.Write "         }"
    response.write " .hld-abs {"
    response.write "    bottom: 20px;"
    response.write "    z-index: 999;"
    response.write "    display: none;"
    response.write "  }"
    response.write "  .prc-hld {"
    response.write "    background-color: #f9fafb;"
    response.write "    border-radius: 12px;"
    response.write "    box-shadow: 1px 1px 15px 0px #dfdfdf;"
    response.write "  }"
    response.write "  .tbls tr td {"
    response.write "    border: none !important;"
    response.write "    background: none !important;"
    response.write "  }"
    response.write "  .rlt-act:hover .hld-abs {"
    response.write "    display: block;"
    response.write "  }"
    response.write "         @media print {"
    response.write "           .dnp {"
    response.write "             display: none !important;"
    response.write "           }"
    response.write "         }"
    response.write "    .min-top {"
    response.write "      right: 20px;"
    response.write "      top: 0;"
    response.write "      visibility: hidden;"
    response.write "      opacity: 0;"
    response.write "      width: 30px;"
    response.write "      height: 30px;"
    response.write "      background: #ededed;"
    response.write "      border-radius: 50%;"
    response.write "      color: #959494;"
    response.write "      transition: all 0.7s ease;"
    response.write "    }"
    response.write "    .t-case:hover .min-top,"
    response.write "    .min-top:hover .t-case-i {"
    response.write "      visibility: visible;"
    response.write "      opacity: 1;"
    response.write "    }"
    response.write "    .icnn {"
    response.write "      transition: all 0.5s ease;"
    response.write "    }"
    response.write "    .t-case-i {"
    response.write "      top: -11px;"
    response.write "      right: 13px;"
    response.write "      background: #efefef;"
    response.write "      padding: 2px 4px;"
    response.write "      border-radius: 5px;"
    response.write "      color: #595959;"
    response.write "      font-size: 13px;"
    response.write "      visibility: hidden;"
    response.write "      opacity: 0;"
    response.write "      transition: all 1s ease;"
    response.write "    }"
    response.write "    .min-top:hover {"
    response.write "      background: #d1d1d1;"
    response.write "      color: #474747;"
    response.write "    }"
    response.write "    .act-t {"
    response.write "      visibility: visible;"
    response.write "      opacity: 1;"
    response.write "    }"
    response.write "    .act-t > .fa-angle-up {"
    response.write "      rotate: 180deg;"
    response.write "    }"
    response.write "    .t-case-m {"
    response.write "      padding-top: 0;"
    response.write "      padding-bottom: 2px;"
    response.write "    }"
    response.write "    .dn {"
    response.write "      max-width: 0;"
    response.write "      overflow: hidden;"
    response.write "      display: none;"
    response.write "    }"
    response.write "    .mw-115 {"
    response.write "      min-width: 115px;"
    response.write "    }"
    response.write "    .mw-300 {"
    response.write "      min-width: 300px;"
    response.write "    }"
    response.write "       .t-right {"
    response.write "         text-align: right;"
    response.write "         padding-right: 8px;"
    response.write "       }"
    response.write "       .t-left {"
    response.write "         text-align: left;"
    response.write "       }"
    response.write "       .t-center {"
    response.write "         text-align: center;"
    response.write "       }"
    response.write "       .fh-s {"
    response.write "         padding: 7px 16px;"
    response.write "         font-size: 12px;"
    response.write "         font-weight: 600;"
    response.write "       }"
    response.write "   .licnt {"
    response.write "     border-radius: 8px;"
    response.write "     border: 1px solid #ddd;"
    response.write "     background: whitesmoke;"
    response.write "     top: 0px;"
    response.write "     z-index: 99;"
    response.write "   }"
    response.write "   .noti{"
    response.write "     border-radius: 10px;"
    response.write "     width: fit-content;"
    response.write "   }"
    response.write "   .revl{"
    response.write "     max-width: 0px;"
    response.write "     padding: 0px;"
    response.write "     transition: all 0.8s ease;"
    response.write "     overflow: hidden;"
    response.write "     white-space: nowrap;"
    response.write "   }"
    response.write "   .noti:hover .revl{"
    response.write "     max-width: 160px;"
    response.write "     padding: 3px 8px;"
    response.write "   }"
    response.write "  .cntslt{"
    response.write "    padding: 8px 10px;"
    response.write "    margin: 5px;"
    response.write "    border-radius: 5px;"
    response.write "    min-width: 180px;"
    response.write "    background: white;"
    response.write "    box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);"
    response.write "  }"
    response.write "  .tpslt{"
    response.write "    background-color: #dedede;"
    response.write "    width: -webkit-fill-available;"
    response.write "    border-radius: 5px;"
    response.write "    font-size: 14px;"
    response.write "    padding: 5px 8px;"
    response.write "  }"
    ' response.write "  input[type=""checkbox""] {"
    ' response.write "    display: none;"
    ' response.write "  }"
    ' response.write "  input[type=""checkbox""] + label {"
    ' response.write "    position: relative;"
    ' response.write "    padding-left: 25px;"
    ' response.write "    cursor: pointer;"
    ' response.write "  }"
    ' response.write "  input[type=""checkbox""] + label:before {"
    ' response.write "    content: '';"
    ' response.write "    position: absolute;"
    ' response.write "    left: 0;"
    ' response.write "    top: 1px;"
    ' response.write "    width: 15px;"
    ' response.write "    height: 15px;"
    ' response.write "    border: 2px solid #a8a8a8;"
    ' response.write "    background-color: #fff;"
    ' response.write "  }"
    ' response.write "  input[type=""checkbox""]:checked + label:before {"
    ' response.write "    background-color: #41aaff; "
    ' response.write "  }"
    ' response.write "  input[type=""checkbox""] + label:after {"
    ' response.write "    content: '';"
    ' response.write "    position: absolute;"
    ' response.write "    left: 5px;"
    ' response.write "    top: 4px;"
    ' response.write "    width: 8px;"
    ' response.write "    height: 8px;"
    ' response.write "    border: solid #fff;"
    ' response.write "    border-width: 0 2px 2px 0;"
    ' response.write "    transform: rotate(45deg);"
    ' response.write "    display: none;"
    ' response.write "  }"
    ' response.write "  input[type=""checkbox""]:checked + label:after {"
    ' response.write "    display: block;"
    ' response.write "  }"
    response.write "  .chcklst::-webkit-scrollbar {"
    response.write "    width: 5px;"
    response.write "    height: 5px;"
    response.write "  }"
    response.write "  .chcklst::-webkit-scrollbar-track {"
    response.write "    background: #efefef;"
    response.write "  }"
    response.write "  .chcklst::-webkit-scrollbar-thumb {"
    response.write "    background: #b4b4b4;"
    response.write "  }"
    response.write "  .chcklst::-webkit-scrollbar-thumb:hover {"
    response.write "    background: #888;"
    response.write "  }"
    response.write "  .chcklst::-webkit-scrollbar-button:hover {"
    response.write "    background: #888;"
    response.write "  }"
    response.write "  .chcklst{"
    response.write "    max-height: 250px;"
    response.write "    overflow-y: auto;"
    response.write "  }"
    response.write "     </style>"
    
End Sub

Sub TableEXScp()

    response.write " <script>"
    response.write "   var prevButton = document.getElementById('prevPage');"
    response.write "   var nextButton = document.getElementById('nextPage');"
    response.write "   var currentPageDisplay = document.getElementById('currentPage');"
    response.write "   var table = document.querySelector('.tbl2');"
    response.write "   var rows = Array.from(table.querySelectorAll('tbody tr'));"
    response.write "   var searchInput = document.getElementById('searchInput');"
    response.write "   var printButton = document.getElementById('printButton');"
    response.write "   var rowsPerPage = 10;"
    response.write "   var tbody = table.querySelector('tbody');"
    response.write "   var ths = Array.from(table.querySelectorAll('th'));"
    response.write "   let currentPage = 1;"
    ' response.write "   function displayRows() {"
    ' response.write "     const startIndex = (currentPage - 1) * rowsPerPage;"
    ' response.write "     const endIndex = startIndex + rowsPerPage;"
    ' response.write "     rows.forEach((row, index) => {"
    ' response.write "       if (index >= startIndex && index < endIndex) {"
    ' response.write "         row.style.display = 'table-row';"
    ' response.write "       } else {"
    ' response.write "         row.style.display = 'none';"
    ' response.write "       }"
    ' response.write "     });"
    ' response.write "   }"
    ' response.write "   displayRows();"
    ' response.write "   prevButton.addEventListener('click', () => {"
    ' response.write "     if (currentPage > 1) {"
    ' response.write "       currentPage--;"
    ' response.write "       currentPageDisplay.textContent = currentPage;"
    ' response.write "       displayRows();"
    ' response.write "     }"
    ' response.write "   });"
    ' response.write "   nextButton.addEventListener('click', () => {"
    ' response.write "     if (currentPage < Math.ceil(rows.length / rowsPerPage)) {"
    ' response.write "       currentPage++;"
    ' response.write "       currentPageDisplay.textContent = currentPage;"
    ' response.write "       displayRows();"
    ' response.write "     }"
    ' response.write "   });"
    response.write "   function filterRows() {"
    response.write "     var query = searchInput.value.toLowerCase();"
    response.write "     rows.forEach((row) => {"
    response.write "       var text = row.innerText.toLowerCase();"
    response.write "       if (text.includes(query)) {"
    response.write "         row.style.display = 'table-row';"
    response.write "       } else {"
    response.write "         row.style.display = 'none';"
    response.write "       }"
    response.write "     });"
    response.write "   }"
    response.write "   searchInput.addEventListener('input', filterRows);"
    response.write "   function getDataType(columnIndex) {"
    response.write "     var rows = Array.from(tbody.querySelectorAll('tr'));"
    response.write "     for (var row of rows) {"
    response.write "       var cellValue = row.querySelector("
    response.write "         `td:nth-child(${columnIndex + 1})`"
    response.write "       ).textContent;"
    response.write "       if (!isNaN(parseFloat(cellValue))) {"
    response.write "         return 'number';"
    response.write "       }"
    response.write "     }"
    response.write "     return 'string';"
    response.write "   }"
    response.write "   function sortTable(columnIndex) {"
    response.write "     if (ths[columnIndex].classList.contains('nosort')) {"
    response.write "       return;"
    response.write "     }"
    response.write "     var dataType = getDataType(columnIndex);"
    response.write "     var isAscending ="
    response.write "       ths[columnIndex].getAttribute('data-sort') === 'asc';"
    response.write "     var rows = Array.from(tbody.querySelectorAll('tr'));"
    response.write "     rows.sort((a, b) => {"
    response.write "       var cellA = a.querySelector("
    response.write "         'td:nth-child(' + (columnIndex + 1) + ')'"
    response.write "       ).textContent;"
    response.write "       var cellB = b.querySelector("
    response.write "         'td:nth-child(' + (columnIndex + 1) + ')'"
    response.write "       ).textContent;"
    response.write "       if (dataType === 'number') {"
    response.write "         return isAscending"
    response.write "           ? parseFloat(cellA) - parseFloat(cellB)"
    response.write "           : parseFloat(cellB) - parseFloat(cellA);"
    response.write "       } else {"
    response.write "         return isAscending"
    response.write "           ? cellA.localeCompare(cellB)"
    response.write "           : cellB.localeCompare(cellA);"
    response.write "       }"
    response.write "     });"
    response.write "     rows.forEach((row) => tbody.appendChild(row));"
    response.write "     ths.forEach((th) => th.setAttribute('data-sort', 'none'));"
    response.write "     ths[columnIndex].setAttribute("
    response.write "       'data-sort',"
    response.write "       isAscending ? 'desc' : 'asc'"
    response.write "     );"
    response.write "   }"
    response.write "   ths.forEach((th, index) => {"
    response.write "     th.addEventListener('click', () => {"
    response.write "       sortTable(index);"
    response.write "     });"
    response.write "   });"
    response.write "   function exportTableToExcel() {"
    response.write "     var table = document.querySelector('table');"
    response.write "     var rows = Array.from(table.querySelectorAll('tr'));"
    response.write "     let excelContent = '<table>';"
    response.write "     rows.forEach((row) => {"
    response.write "       var cells = Array.from(row.querySelectorAll('td, th')); "
    response.write "       excelContent += '<tr>';"
    response.write "       cells.forEach((cell, index) => {"
    response.write "         if ("
    response.write "           !table"
    response.write "             .querySelector(`th:nth-child(${index + 1}`)"
    response.write "             .classList.contains('ignore')"
    response.write "         ) {"
    response.write "           excelContent += `<td>${cell.textContent}</td>`;"
    response.write "         }"
    response.write "       });"
    response.write "       excelContent += '</tr>';"
    response.write "     });"
    response.write "     excelContent += '</table>';"
    response.write "     var excelBlob = new Blob([excelContent], {"
    response.write "       type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',"
    response.write "     });"
    response.write "     var link = document.createElement('a');"
    response.write "     link.href = URL.createObjectURL(excelBlob);"
    response.write "     link.setAttribute('download', 'table_data.xls');"
    response.write "     link.click();"
    response.write "   }"
    response.write "   function exportTableToCSV() {"
    response.write "     var table = document.querySelector('table');"
    response.write "     var rows = Array.from(table.querySelectorAll('tr'));"
    response.write "     let csvContent = '';"
    response.write "     rows.forEach((row) => {"
    response.write "       var cells = Array.from(row.querySelectorAll('td, th')); "
    response.write "       csvContent += cells.map((cell) => `'${cell.textContent}'`).join(',');"
    response.write "       csvContent += '\n';"
    response.write "     });"
    response.write "     var csvBlob = new Blob([csvContent], {"
    response.write "       type: 'text/csv;charset=utf-8;',"
    response.write "     });"
    response.write "     var link = document.createElement('a');"
    response.write "     link.href = URL.createObjectURL(csvBlob);"
    response.write "     link.setAttribute('download', 'table_data.csv');"
    response.write "     link.click();"
    response.write "   }"
    ' response.write "   var exportExcelButton = document.getElementById('exportExcel');"
    ' response.write "   exportExcelButton.addEventListener('click', exportTableToExcel);"
    ' response.write "   var exportCSVButton = document.getElementById('exportCSV');"
    ' response.write "   exportCSVButton.addEventListener('click', exportTableToCSV);"
    response.write "   function printTable() {"
    response.write "     window.print();"
    response.write "   }"
    response.write "   printButton.addEventListener('click', printTable);"
    response.write " </script>"

End Sub

Sub ScpAdded()
    response.write "<script>"
    response.write " const cntTp = document.querySelector('.cnt');"
    response.write " const cntTptg = document.querySelector('.min-top');"
    response.write " const cntTc = document.querySelector('.t-case');"
    response.write " const cntTci = document.querySelector('.t-case-i');"
    response.write " cntTptg.addEventListener('click', () => {"
    response.write "   cntTptg.classList.toggle('act-t');"
    response.write "   if (cntTptg.classList.contains('act-t')) {"
    response.write "     cntTp.classList.add('dn');"
    response.write "     cntTc.classList.add('t-case-m');"
    response.write "     cntTci.textContent = 'Maximize';"
    response.write "   } else {"
    response.write "     cntTp.classList.remove('dn');"
    response.write "     cntTc.classList.remove('t-case-m');"
    response.write "     cntTci.textContent = 'Minimize';"
    response.write "   }"
    response.write " });"
    response.write " function openPopup1(linkUrl, width, height) {"
    response.write " var left = (window.innerWidth - width) / 2;"
    response.write " var top = (window.innerHeight - height) / 2;"
    response.write " window.open(linkUrl, 'PopupWindow', 'width=' + width + ', height=' + height + ', left=' + left + ', top=' + top);"
    response.write " }"
    response.write " function openLinkInNew(url) {"
    response.write "     window.open(url, '_blank');"
    response.write "   }"
    response.write "</script>"
End Sub
 
Sub DashBoardStylesAdded()
    response.write "     <style>"
    response.write "#total{"
    response.write "    display:flex;"
    response.write "    justify-content: space-between;"
    response.write "    padding: 10px;"
    response.write "}"
    response.write ""
    response.write ".fa-regular{"
    response.write "color: yellow;"
    response.write "padding: 10px;"
    response.write "font-size: 20px;"
    response.write "border-radius:50%;"
    response.write "background-color:red;"
    response.write "}"
    response.write ".dashboard{"
    response.write "display: flex;"
    response.write "justify-content: space-around;"
    response.write "background-color:floralwhite;"
    response.write "}"
    response.write ".right{"
    response.write "padding-left: 10px;"
    response.write "}"
    response.write "     </style>"
End Sub


'<<--END_CODE_SEGMENT_PRINTHEADER-->>
'>
'>
'>
'>
'>
'<<--BEGIN_CODE_SEGMENT_PRINTFOOTER-->>

'<<--END_CODE_SEGMENT_PRINTFOOTER-->>
