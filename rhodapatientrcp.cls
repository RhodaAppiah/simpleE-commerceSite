'<<--BEGIN_CODE_SEGMENT_PRINTHEADER-->>
Dim strPatientID, strVisitationID, linkUrl
Dim str, lnkCnt
lnkCnt = 0
reqPatflag = Trim(Request.QueryString("patientflag"))
reqPatID = Trim(Request.QueryString("PatientID"))
response.Clear

response.write " <!DOCTYPE html>"
response.write " <html>"
response.write "   <head>"
response.write "    <link rel='stylesheet' type='text/css' href='fontawesome-free-6.4.0-web/css/all.css'/>"
response.write "     <title>" & GetRecordField("PatientName") & "</title>"

'LoadCSS
stylesButton
StylesAdded
LoaderModalStys
response.write " </head>"
response.write " <body>"
response.write "   <div class='content-main' style='font-family: Segoe UI;'>"
If HasAccessRight(uName, "frmPatient", "View") Then
    DisplayControlPanel
    LoaderModal
    'response.write " <script src= 'https://kit.fontawesome.com/91bd23ceba.js'></script>"
    LoaderModalScp
    ScpAdded
End If
response.write "    </div>"
response.write "  </body>"
response.write "</html>"



'strPatientID = GetRecordField("PatientID") '"0246046" '"0213971"
''strVisitationID = "V7150528028"
'
'response.write "" & _
'        "<style type='text/css'>" & _
'                getCSS() & _
'        "</style>" & _
'        "<div style='text-align:left;'>" & _
'                getPatientRecCtrlSect(strPatientID) & _
'        "</div>"

Sub DisplayControlPanel()
    Dim ag, tb, sTb, tbKy, sTbKy, tbNm, sTbNm, pat, hasAcc, wd, imgSrc, ot
    Dim lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor
    tb = "Patient"
    tbKy = "PatientID"
    tbNm = "Patient"
    sTb = ""
    sTbKy = ""
    sTbNm = ""
    wd = "100%"
    pat = GetRecordField(tbKy)
    'Load Image
    imgSrc = ""
    ot = GetConvertImageFile(rstRec.fields("PatientPhoto1"))
    If Not IsNull(ot) Then
        If UCase(Left(Trim(ot), 10)) = "DATA:IMAGE" Then
            imgSrc = ot
        Else
            imgSrc = "wpgFileDownloadUni.asp?PositionForTableName=" & tb
        End If
    End If
    ' response.write "<table width=""100%"" border=""0"" cellpadding=""2"" cellspacing=""0"" >"
    '   response.write "<tr>"
    '     response.write "<td>"
    '     OpenPanelSection
    '       response.write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">"
    '         response.write "<tr class=""cpHdrTr"">"
    '           response.write "<td colspan=""2""><table border=""0"" cellpadding=""3"" cellspacing=""0""><tr>"
    '           response.write "<td class=""cpHdrTd"">Patient Information&nbsp;&nbsp;</td>"
    '           'If HasAccessRight(uName, "frm" & tb, "View") Then
    '             response.write "<td>"
    response.write "     <div id='sec1' class='tab-content'>"
    response.write "       <div class='tab-holder'>"
    response.write "         <div class='tab-head df'>"
    response.write "           <div class='df'>"
    response.write "             <div class='head-lb cp hdr'>Patient Information</div>"
    response.write "             <div class='sec-btns df'>"
    'Clickable Url Link
    lnkCnt = lnkCnt + 1
    lnkID = "lnk" & CStr(lnkCnt)
    'lnkText = "<b>&nbsp;&nbsp;View</b>"
    lnkText = "View"
    lnkUrl = "wpg" & tb & ".asp?PageMode=ProcessSelect&" & tbKy & "=" & pat
    navPop = "POP"
    inout = "IN"
    fntSize = ""
    fntColor = "#444488"
    bgColor = ""
    wdth = ""
    ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
    ' response.write "</td>"
    response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"

    'End If
    If HasAccessRight(uName, "frm" & tb, "New") Then
        ' response.write "<td>"
        'Clickable Url Link
        lnkCnt = lnkCnt + 1
        lnkID = "lnk" & CStr(lnkCnt)
        ' lnkText = "<b>&nbsp;&nbsp;Add New " & tbNm & "</b>"
        lnkText = "Add New " & tbNm
        lnkUrl = "wpg" & tb & ".asp?PageMode=AddNew"
        navPop = "POP"
        inout = "IN"
        fntSize = ""
        fntColor = "#444488"
        bgColor = ""
        ' wdth = ""
        ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
        ' response.write "</td>"
        response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
    End If
    hasAcc = HasPrintOutAccess(jSchd, "SelectPatient")
    navPop = "POP"
    If hasAcc Then
        navPop = "NAV"
        lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=SearchPatient&PositionForTableName=WorkingDay&"
        ' lnkUrl = lnkUrl & "&FilterHeight=170&FilterPerRow=2&PositionForTableName=WorkingDay&WorkingDayID=DAY20160401"
    Else
        hasAcc = HasAccessRight(uName, "frm" & tb, "FormSearch")
        If hasAcc Then
            lnkUrl = "wpgSrh" & tb & ".asp"
            navPop = "POP"
        End If
    End If
    If hasAcc Then
        ' response.write "<td>"
        ' 'Clickable Url Link
        lnkCnt = lnkCnt + 1
        lnkID = "lnk" & CStr(lnkCnt)
        ' lnkText = "<b>&nbsp;&nbsp;Search</b>"
        lnkText = "Search"
        'navPop = "POP"
        'lnkUrl = "wpgSrh" & tb & ".asp"
        inout = "IN"
        fntSize = ""
        fntColor = "#444488"
        bgColor = ""
        wdth = ""
        ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
        ' response.write "</td>"
        response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
    End If
    If HasAccessRight(uName, "frm" & tb, "New") Then
        lnkUrl1 = "wpgPrtPrintInputFilter.asp?PrintLayoutName=MergePatient&PositionForTableName=Patient&PatientID=" & GetRecordField("PatientID")
        lnkText = "Merge Patient Records"
        response.write "               <div onclick=""openModal('" & lnkUrl1 & "')"" class=' btsty bss bold'>" & lnkText & "</div>"
    End If
    lnkUrl1 = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=PrintIdCard&PositionForTableName=WorkingDay&WorkingDayID=&patientid=" & GetRecordField("PatientID") & "&PrintType=front"
    lnkText = "PrintID [1]"
    response.write "               <div onclick=""openModal('" & lnkUrl1 & "')"" class=' btsty bs bold'>" & lnkText & "</div>"
    
    lnkUrl1 = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=PrintIdCard&PositionForTableName=WorkingDay&WorkingDayID=&patientid=" & GetRecordField("PatientID") & "&PrintType=back"
    lnkText = "PrintID [2]"
    response.write "               <div onclick=""openModal('" & lnkUrl1 & "')"" class=' btsty bs bold'>" & lnkText & "</div>"
    'Update PatientInfo For IDCard Printed
    'cardval = GetRecordField("PatientInfo1")
    cardval = GetComboNameFld("Patient", reqPatID, "PatientInfo1")
    If cardval = "Printed" Then
        response.write "               <div class=' btsty bss bold'>Card Printed</div>"
    Else
        response.write "               <div onclick=""GetDataFromDb2()"" class=' btsty bwrn bold'>Card Not Printed</div>"
    End If

    If Not CheckVst(pat) And Not BillAccount(pat) Then
        response.write "<div data-patID = '" & pat & "' class='btn-del'>Delete Patient</div>"
    End If
    
    If reqPatflag = "true" Then
        conn.execute qryPro.FltQry(("DELETE from InsuredPatient where patientID = '" & pat & "'"))
        conn.execute qryPro.FltQry(("DELETE from NextOfKin where patientID = '" & pat & "'"))
        conn.execute qryPro.FltQry(("DELETE from Patient where patientID = '" & pat & "'"))
    End If
    

    response.write "             </div>"
    response.write "           </div>"
    response.write "           <div class='head-right df'>"
    response.write "             <div class='plr10'>"
    response.write "               <i class='fa-solid fa-angle-down icn cp rotate'></i>"
    response.write "             </div>"
    response.write "           </div>"
    response.write "         </div>"
    response.write "         <div class='tab-tbl-hld'>"
    response.write "           <div class='tab-table'>"
    response.write "             <div class='table-holder'>"
    response.write "               <div class='patient-profile'>"
    response.write "                 <div class='pt-img'>"
    response.write "                   <img src='" & imgSrc & "' alt='' height='150' width='150' />"
    response.write "                 </div>"

    response.write "                 <div class='pt-details' style='display: flex;'>"
    'response.write "                   <div class='details1'>"
    response.write "                   <table style='font-size: 14px; padding-inline: 10px; width: 100%; height: 100%; margin: auto;'><tr><td style='padding-inline: 10px;'>"
    response.write "                     <table>"
    response.write "                       <tr>"
    tID = GetRecordField("TitleID")
    If tID <> "0" Then
        ttl = GetComboName("Title", tID)
    Else
        ttl = ""
    End If
    response.write "                         <td class='lb1'>Name</td>"
    response.write "                         <td class='lb2b'>" & ttl & " " & GetRecordField("PatientName") & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Gender</td>"
    response.write "                         <td class='lb2'>" & GetRecordField("GenderName") & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Age</td>"
    ag = Int((DateDiff("d", CDate(GetRecordField("BirthDate")), Now())) / 365.24)
    response.write "                         <td class='lb2'>" & CStr(ag) & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Marital Status</td>"
    response.write "                         <td class='lb2'>" & GetRecordField("MaritalStatusName") & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Contact</td>"
    response.write "                         <td class='lb2'>" & GetRecordField("ResidencePhone") & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Occupation</td>"
    response.write "                         <td class='lb2'>" & GetRecordField("Occupation") & "</td>"
    response.write "                       </tr>"
    response.write "                     </table>"
    response.write "                   </td>"
    'response.write "                   </div>"
    
    'response.write "                   <div class='details1'>" 'style='font-size: 14px; padding-inline: 10px;'
    response.write "                   <td style='padding-inline: 10px;'>"
    response.write "                     <table>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Patient No</td>"
    response.write "                         <td class='lb2b'>" & GetRecordField("PatientID") & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Type</td>"
    response.write "                         <td class='lb2'>" & GetRecordField("PatientTypeName") & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Date of Birth</td>"
    response.write "                         <td class='lb2'>" & FormatDate(GetRecordField("BirthDate")) & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Register Date</td>"
    response.write "                         <td class='lb2'>" & FormatDate(GetRecordField("FirstVisitDate")) & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Address</td>"
    response.write "                         <td class='lb2'>" & GetRecordField("ResidenceAddress") & "</td>"
    response.write "                       </tr>"
    response.write "                       <tr>"
    response.write "                         <td class='lb1'>Email</td>"
    response.write "                         <td class='lb2'>" & GetRecordField("EmailAddress") & "</td>"
    response.write "                       </tr>"
    response.write "                     </table>"
    response.write "                   </td></tr></table>"
    'response.write "                   </div>"
    response.write "                 </div>"
    response.write "               </div>"
    response.write "             </div>"
    response.write "           </div>"
    response.write "         </div>"
    response.write "       </div>"
    response.write "     </div>"
    '   response.write "</tr></table></td>"
    ' response.write "</tr>"
    ' 'Patient Detail
    ' response.write "<tr>"
    ' response.write "<td valign=""top"" align=""center""><table border=""0"" cellpadding=""0"" cellspacing=""4""><tr>"
    ' response.write "<td width=""150"" height=""150"" style=""border-style: solid; border-width: 1px"" align=""center"">"
    ' response.write "<img height=""150"" width=""150"" src=""" & imgSrc & """></td>"
    ' response.write "</tr></table></td>"
    ' response.write "<td>"
    ' response.write "<table width=""100%"" border=""0"" cellpadding=""2"" cellspacing=""0"">"
    '   response.write "<tr>"
    '           response.write "<td align=""right"">Name&nbsp;:&nbsp;</td>"
    '           response.write "<td  class=""cpHdrTd"">" & GetRecordField("PatientName") & "</td>"
    '           response.write "<td align=""right"">Patient No.&nbsp;:&nbsp;</td>"
    '           response.write "<td class=""cpHdrTd"">" & GetRecordField("PatientID") & "</td>"
    '         response.write "</tr>"
    '         response.write "<tr>"
    '           response.write "<td align=""right"">Gender&nbsp;:&nbsp;</td>"
    '           response.write "<td>" & GetRecordField("GenderName") & "</td>"
    '           response.write "<td align=""right"">Type&nbsp;:&nbsp;</td>"
    '           response.write "<td>" & GetRecordField("PatientTypeName") & "</td>"
    '         response.write "</tr>"
    '         response.write "<tr>"
    '           response.write "<td align=""right"">Age&nbsp;:&nbsp;</td>"
    '           ag = Int((DateDiff("d", CDate(GetRecordField("BirthDate")), Now())) / 365.24)
    '           response.write "<td>" & CStr(ag) & "</td>"
    '           response.write "<td align=""right"">Date of Birth&nbsp;:&nbsp;</td>"
    '           response.write "<td>" & FormatDate(GetRecordField("BirthDate")) & "</td>"
    '         response.write "</tr>"
    '         response.write "<tr>"
    '           response.write "<td align=""right"">Marital Status&nbsp;:&nbsp;</td>"
    '           response.write "<td>" & GetRecordField("MaritalStatusName") & "</td>"
    '           response.write "<td align=""right"">Register Date&nbsp;:&nbsp;</td>"
    '           response.write "<td>" & FormatDate(GetRecordField("FirstVisitDate")) & "</td>"
    '         response.write "</tr>"
    '         response.write "<tr>"
    '           response.write "<td align=""right"">Contact&nbsp;:&nbsp;</td>"
    '           response.write "<td>" & GetRecordField("ResidencePhone") & "</td>"
    '           response.write "<td align=""right"">Address&nbsp;:&nbsp;</td>"
    '           response.write "<td>" & GetRecordField("ResidenceAddress") & "</td>"
    '         response.write "</tr>"
    '         response.write "<tr>"
    '           response.write "<td align=""right"">Occupation&nbsp;:&nbsp;</td>"
    '           response.write "<td>" & GetRecordField("Occupation") & "</td>"
    '           response.write "<td align=""right"">Email&nbsp;:&nbsp;</td>"
    '           response.write "<td>" & GetRecordField("EmailAddress") & "</td>"
    '         response.write "</tr>"
    '       response.write "</table>"
    '       response.write "</td>"
    '     response.write "</tr>"
    '   response.write "</table>"
    '   ClosePanelSection
    ' response.write "</td>"
    ' response.write "</tr>"

    'Alerts
    sTb = "PatientFlag"
    sTbKy = "PatientFlagID"
    sTbNm = "Alert/Flag"
    If HasAccessRight(uName, "frm" & sTb, "View") Then
        '  response.write "<tr>"
        '   response.write "<td>"
        '     OpenPanelSection
        '       response.write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">"
        '       'Header
        '       response.write "<tr>"

        '         response.write "<td>"
        '           response.write "<table width=""" & wd & """ border=""0"" cellpadding=""0"" cellspacing=""0"">"
        '             response.write "<tr class=""cpHdrTr"">"
        '               response.write "<td><table border=""0"" cellpadding=""2"" cellspacing=""0""><tr>"
        '               response.write "<td class=""cpHdrTd"">Alerts / Flags</td>"
        response.write "     <div id='sec1' class='tab-content'>"
        response.write "       <div class='tab-holder'>"
        response.write "         <div class='tab-head df'>"
        response.write "           <div class='df'>"
        response.write "             <div class='head-lb cp hdr'>Alerts / Flags</div>"
        response.write "             <div class='sec-btns df'>"
        If HasAccessRight(uName, "frm" & sTb, "New") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Add New </b>"
            lnkText = "Add New"
            lnkUrl = "wpg" & sTb & ".asp?PageMode=AddNew&PullupData=" & tbKy & "||" & pat
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        If HasAccessRight(uName, "frm" & sTb, "FormSearch") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Search</b>"
            lnkText = "Search"
            lnkUrl = "wpgSrh" & sTb & ".asp"
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        response.write "             </div>"
        response.write "           </div>"
        response.write "           <div class='head-right df'>"
        response.write "             <div class='plr10'>"
        response.write "               <i class='fa-solid fa-angle-down icn cp rotate'></i>"
        response.write "             </div>"
        response.write "           </div>"
        response.write "         </div>"
        '         response.write "</tr></table></td>"
        '       response.write "</tr>"
        '     response.write "</table>"
        '   response.write "</td>"
        ' response.write "</tr>"
        ' 'Detail
        AddPatientFlag sTb, sTbKy, pat
        response.write "       </div>"
        response.write "     </div>"
        '     response.write "</table>" 'Alerts
        '     ClosePanelSection
        '   response.write "</td>"
        '  response.write "</tr>"
    End If

    'Billing Account
    sTb = "InsuredPatient"
    sTbKy = "InsuredPatientID"
    sTbNm = "Billing Account"
    If HasAccessRight(uName, "frm" & sTb, "View") Then
        '  response.write "<tr>"
        '   response.write "<td>"
        '   OpenPanelSection
        '   response.write "<table width=""100%"" border=""0"" cellpadding=""2"" cellspacing=""0"">"
        '       'Header
        '       response.write "<tr>"

        '         response.write "<td>"
        '           response.write "<table width=""" & wd & """ border=""0"" cellpadding=""0"" cellspacing=""0"">"
        '             response.write "<tr class=""cpHdrTr"">"
        '              response.write "<td><table border=""0"" cellpadding=""2"" cellspacing=""0""><tr>"
        '               response.write "<td class=""cpHdrTd"">" & sTbNm & "</td>"
        response.write "     <div id='sec1' class='tab-content'>"
        response.write "       <div class='tab-holder'>"
        response.write "         <div class='tab-head df'>"
        response.write "           <div class='df'>"
        response.write "             <div class='head-lb cp hdr'>" & sTbNm & "</div>"
        response.write "             <div class='sec-btns df'>"
        If HasAccessRight(uName, "frm" & sTb, "New") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Add New </b>"
            lnkText = "Add New"
            lnkUrl = "wpg" & sTb & ".asp?PageMode=AddNew&PullupData=" & tbKy & "||" & pat
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        If HasAccessRight(uName, "frm" & sTb, "FormSearch") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Search</b>"
            lnkText = "Search"
            lnkUrl = "wpgSrh" & sTb & ".asp"
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        '        response.write "</tr></table></td>"
        '       response.write "</tr>"
        '     response.write "</table>"
        '   response.write "</td>"
        ' response.write "</tr>"
        ' 'Detail
        response.write "             </div>"
        response.write "           </div>"
        response.write "           <div class='head-right df'>"
        response.write "             <div class='plr10'>"
        response.write "               <i class='fa-solid fa-angle-down icn cp rotate'></i>"
        response.write "             </div>"
        response.write "           </div>"
        response.write "         </div>"
        AddInsuredPatient sTb, sTbKy, pat
        '     response.write "</table>" 'Billing Account
        '     ClosePanelSection
        '   response.write "</td>"
        '  response.write "</tr>"
        response.write "        </div>"
        response.write "      </div>"
    End If

    'NextOfKin
    sTb = "NextOfKin"
    sTbKy = "NextOfKinID"
    sTbNm = "Next Of Kin"
    If HasAccessRight(uName, "frm" & sTb, "View") Then
        '  response.write "<tr>"
        '   response.write "<td>"
        '   OpenPanelSection
        '   response.write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">"
        '       'Header
        '       response.write "<tr>"

        '         response.write "<td>"
        '           response.write "<table width=""" & wd & """ border=""0"" cellpadding=""0"" cellspacing=""0"">"
        '             response.write "<tr class=""cpHdrTr"">"
        '              response.write "<td><table border=""0"" cellpadding=""2"" cellspacing=""0""><tr>"
        '                response.write "<td class=""cpHdrTd"">" & sTbNm & "</td>"
        response.write "     <div id='sec1' class='tab-content'>"
        response.write "       <div class='tab-holder'>"
        response.write "         <div class='tab-head df'>"
        response.write "           <div class='df'>"
        response.write "             <div class='head-lb cp hdr'>" & sTbNm & "</div>"
        response.write "             <div class='sec-btns df'>"
        If HasAccessRight(uName, "frm" & sTb, "New") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Add New </b>"
            lnkText = "Add New"
            lnkUrl = "wpg" & sTb & ".asp?PageMode=AddNew&PullupData=" & tbKy & "||" & pat
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        If HasAccessRight(uName, "frm" & sTb, "FormSearch") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Search</b>"
            lnkText = "Search"
            lnkUrl = "wpgSrh" & sTb & ".asp"
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        response.write "             </div>"
        response.write "           </div>"
        response.write "           <div class='head-right df'>"
        response.write "             <div class='plr10'>"
        response.write "               <i class='fa-solid fa-angle-down icn cp rotate'></i>"
        response.write "             </div>"
        response.write "           </div>"
        response.write "         </div>"
        '         response.write "</tr></table></td>"
        '       response.write "</tr>"
        '     response.write "</table>"
        '   response.write "</td>"
        ' response.write "</tr>"
        ' 'Detail
        AddNextOfKin sTb, sTbKy, pat
        response.write "       </div>"
        response.write "     </div>"
        '     response.write "</table>" 'NextOfKin
        '     ClosePanelSection
        '   response.write "</td>"
        '  response.write "</tr>"
    End If

    'Appointment
    sTb = "Appointment"
    sTbKy = "AppointmentID"
    sTbNm = "Appointment"
    If HasAccessRight(uName, "frm" & sTb, "View") Then
        '  response.write "<tr>"
        '   response.write "<td>"
        '   OpenPanelSection
        '   response.write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">"
        '       'Header
        '       response.write "<tr>"

        '         response.write "<td>"
        '           response.write "<table width=""" & wd & """ border=""0"" cellpadding=""0"" cellspacing=""0"">"
        '             response.write "<tr class=""cpHdrTr"">"
        '              response.write "<td><table border=""0"" cellpadding=""2"" cellspacing=""0""><tr>"
        '               response.write "<td class=""cpHdrTd"">" & sTbNm & "</td>"
        response.write "     <div id='sec1' class='tab-content'>"
        response.write "       <div class='tab-holder'>"
        response.write "         <div class='tab-head df'>"
        response.write "           <div class='df'>"
        response.write "             <div class='head-lb cp hdr'>" & sTbNm & "</div>"
        response.write "             <div class='sec-btns df'>"
        hasAcc = False
        prt = "MakeAppointmentWeek"
        If HasPrintOutAccess(jSchd, prt) Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Make Weekly Appointment&nbsp;&nbsp;</b>"
            lnkText = "Make Weekly Appointment&nbsp</b>"
            prtTb = "Appointment"
            navPop = "POP"
            hasAcc = True
            navPop = "NAV"
            lnkUrl = "wpgNavigateFrame.asp?FrameType=PrintFilter&PrintLayoutName=" & prt & "&PositionForTableName=Appointment&FilterHeight=70&FilterPerRow=3&PatientID=" & pat
            'If IsMedicalStaff(uName) Then
            'lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=MakeAppointmentWeek&PositionForTableName=" & prtTb & "&" & prtTb & "ID=" & GetRecordField("" & prtTb & "ID")
            'End If
            inout = "IN"
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If

        prt = "MakeAppointment"
        If HasPrintOutAccess(jSchd, prt) Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Make Monthly Appointment&nbsp;&nbsp;</b>"
            lnkText = "Make Monthly Appointment"
            prtTb = "Appointment"
            navPop = "POP"
            hasAcc = True
            navPop = "NAV"
            lnkUrl = "wpgNavigateFrame.asp?FrameType=PrintFilter&PrintLayoutName=" & prt & "&PositionForTableName=Appointment&FilterHeight=70&FilterPerRow=3&PatientID=" & pat
            'If IsMedicalStaff(uName) Then
            'lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=MakeAppointmentWeek&PositionForTableName=" & prtTb & "&" & prtTb & "ID=" & GetRecordField("" & prtTb & "ID")
            'End If
            inout = "IN"
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If

        prt = "MakeAppointmentDay"
        If HasPrintOutAccess(jSchd, prt) Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Make Daily Appointment&nbsp;&nbsp;</b>"
            lnkText = "Make Daily Appointment&nbsp"
            prtTb = "Appointment"
            navPop = "POP"
            hasAcc = True
            navPop = "NAV"
            lnkUrl = "wpgNavigateFrame.asp?FrameType=PrintFilter&PrintLayoutName=" & prt & "&PositionForTableName=Appointment&FilterHeight=70&FilterPerRow=3&PatientID=" & pat
            'If IsMedicalStaff(uName) Then
            'lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=MakeAppointmentWeek&PositionForTableName=" & prtTb & "&" & prtTb & "ID=" & GetRecordField("" & prtTb & "ID")
            'End If
            inout = "IN"
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If

        If HasAccessRight(uName, "frm" & sTb, "New") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Add New </b>"
            lnkText = "Add New"
            lnkUrl = "wpg" & sTb & ".asp?PageMode=AddNew&PullupData=" & tbKy & "||" & pat
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        If HasAccessRight(uName, "frm" & sTb, "FormSearch") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Search</b>"
            lnkText = "Search"
            lnkUrl = "wpgSrh" & sTb & ".asp"
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        response.write "             </div>"
        response.write "           </div>"
        response.write "           <div class='head-right df'>"
        response.write "             <div class='plr10'>"
        response.write "               <i class='fa-solid fa-angle-down icn cp rotate'></i>"
        response.write "             </div>"
        response.write "           </div>"
        response.write "         </div>"
        '         response.write "</tr></table></td>"
        '       response.write "</tr>"
        '     response.write "</table>"
        '   response.write "</td>"
        ' response.write "</tr>"
        ' 'Detail
        AddAppointment sTb, sTbKy, pat
        response.write "       </div>"
        response.write "     </div>"
        '     response.write "</table>" 'Appointment
        '     ClosePanelSection
        '   response.write "</td>"
        '  response.write "</tr>"
    End If
    'Receipt
    sTb = "Receipt"
    sTbKy = "ReceiptID"
    sTbNm = "Receipt"
    If HasAccessRight(uName, "frm" & sTb, "View") Then
        '  response.write "<tr>"
        '   response.write "<td>"
        '   OpenPanelSection
        '   response.write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">"
        '       'Header
        '       response.write "<tr>"

        '         response.write "<td>"
        '           response.write "<table width=""" & wd & """ border=""0"" cellpadding=""0"" cellspacing=""0"">"
        '             response.write "<tr class=""cpHdrTr"">"
        '              response.write "<td><table border=""0"" cellpadding=""2"" cellspacing=""0""><tr>"
        '               response.write "<td class=""cpHdrTd"">" & sTbNm & "</td>"
        response.write "     <div id='sec1' class='tab-content'>"
        response.write "       <div class='tab-holder'>"
        response.write "         <div class='tab-head df'>"
        response.write "           <div class='df'>"
        response.write "             <div class='head-lb cp hdr'>" & sTbNm & "</div>"
        response.write "             <div class='sec-btns df'>"
        If HasAccessRight(uName, "frm" & sTb, "New") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Add New </b>"
            lnkText = "Add New"
            lnkUrl = "wpg" & sTb & ".asp?PageMode=AddNew&PullupData=" & tbKy & "||" & pat
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        If HasAccessRight(uName, "frm" & sTb, "FormSearch") Then
            ' response.write "<td>"
            ' 'Clickable Url Link
            lnkCnt = lnkCnt + 1
            lnkID = "lnk" & CStr(lnkCnt)
            ' lnkText = "<b>&nbsp;&nbsp;Search</b>"
            lnkText = "Search"
            lnkUrl = "wpgSrh" & sTb & ".asp"
            navPop = "POP"
            inout = "IN"
            fntSize = ""
            fntColor = "#444488"
            bgColor = ""
            wdth = ""
            ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
            ' response.write "</td>"
            response.write "               <div onclick=""openModal('" & lnkUrl & "')"" class=' btsty pm bold'>" & lnkText & "</div>"
        End If
        response.write "             </div>"
        response.write "           </div>"
        response.write "           <div class='head-right df'>"
        response.write "             <div class='plr10'>"
        response.write "               <i class='fa-solid fa-angle-down icn cp rotate'></i>"
        response.write "             </div>"
        response.write "           </div>"
        response.write "         </div>"
        '         response.write "</tr></table></td>"
        '       response.write "</tr>"
        '     response.write "</table>"
        '   response.write "</td>"
        ' response.write "</tr>"
        ' 'Detail
        AddReceipt sTb, sTbKy, pat
        response.write "       </div>"
        response.write "     </div>"
        '     response.write "</table>" 'Receipt
        '     ClosePanelSection
        '   response.write "</td>"
        '  response.write "</tr>"
    End If
    ' response.write "</table>"
End Sub

Sub LoadCSS()
    Dim str
    str = ""
    str = str & "<style type='text/css' id=""styPrt"">"
    str = str & ".cpHdrTd{font-size:14pt;font-weight:bold}"
    str = str & ".cpHdrTr{background-color:#eeeeee}"
    str = str & ".cpHdrTd2{font-size:12pt;font-weight:bold}"
    str = str & ".cpHdrTr2{background-color:#eeeeee}" 'fafafa
    str = str & "</style>"

    response.write str
End Sub
Sub AddUrlLink(lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth)
    Dim plusMinus, imgName, lnkOpClNavPop, align
    plusMinus = ""
    imgName = ""
    align = ""
    lnkOpClNavPop = inout & "||" & navPop & "||800||600||CLOSE"
    AddPrtNavLink lnkID, plusMinus, imgName, lnkText, lnkUrl, lnkOpClNavPop, fntSize, fntColor, bgColor, align, wdth
End Sub
'AddPatientFlag
Sub AddPatientFlag(sTb, sTbKy, pat)
    Dim rst, sql, ot, cnt, hdr, adm, det1, dt1, tot, recKy, clr, hasPrt
    Dim lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
    Set rst = CreateObject("ADODB.Recordset")
    sql = "Select * from PatientFlag where Patientid='" & pat & "'"
    sql = sql & " And PatientFlagStatusID='P001'"
    sql = sql & " order by PatientFlagCatid,PatientFlagTypeID"
    cnt = 0
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            .movefirst
            hasPrt = HasPrintOutAccess(jSchd, sTb & "RCP")
            response.write "         <div class='tab-tbl-hld'>"
            response.write "           <div class='tab-table'>"
            response.write "             <div class='table-holder'>"
            response.write "               <table class='tbl'>"
            response.write "                 <thead class='field-h'>"
            response.write "                   <tr class='field-h'>"
            response.write "                     <th class='fh t-center'>No.</th>"
            response.write "                     <th class='fh'>Type</th>"
            response.write "                     <th class='fh'>Detail</th>"
            response.write "                     <th class='fh'>Date</th>"
            response.write "                   </tr>"
            response.write "                 </thead>"
            response.write "                 <tbody class='field-b'>"

            ' response.write "<tr>"

            ' response.write "<td align=""center"">"
            ' response.write "<table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""2"">"

            ' response.write "<tr class=""cpHdrTr2"">"
            ' response.write "<td><u>No.</u></td>"
            ' response.write "<td><u>Type</u></td>"
            ' response.write "<td><u>Detail</u></td>"
            ' response.write "<td><u>Date</u></td>"
            ' 'response.write "<td align=""right""></td>"
            ' response.write "</tr>"

            Do While Not .EOF
                cnt = cnt + 1
                det1 = "-"
                recKy = .fields(sTbKy)
                clr = "ff4444"
                'Clickable Url Link
                lnkUrl = "wpg" & sTb & ".asp?PageMode=ProcessSelect&" & sTbKy & "=" & recKy
                navPop = "POP"
                If hasPrt Then
                    lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=" & sTb & "RCP&PositionForTableName=" & sTb & "&" & sTb & "ID=" & recKy
                    navPop = "NAV"
                End If
                inout = "IN"
                fntSize = ""
                fntColor = clr
                bgColor = ""
                wdth = ""
                If Not IsNull(.fields("FlagDetail1")) Then
                    det1 = Trim(.fields("FlagDetail1"))
                End If
                dt1 = "-"
                If Not IsNull(.fields("FlagDate1")) Then
                    If IsDate(.fields("FlagDate1")) Then
                        dt1 = FormatDate(.fields("FlagDate1"))
                    End If
                End If
                ' response.write "<tr style=""color:" & clr & """>"
                '   response.write "<td>" & CStr(cnt) & "</td>"
                response.write "                   <tr class='field-r'>"
                response.write "                     <td>" & CStr(cnt) & "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("PatientFlagType", .fields("PatientFlagTypeID"))
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"


                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = det1
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = dt1
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'response.write "<td align=""right""></td>"
                ' response.write "</tr>"
                response.write "                   </tr>"
                .movenext
            Loop
            response.write "                 </tbody>"
            response.write "               </table>"
            response.write "             </div>"
            response.write "           </div>"
            response.write "         </div>"
            ' response.write "</table>"
            ' response.write "</td>"
            ' response.write "</tr>"
        End If
        .Close
    End With
    Set rst = Nothing
End Sub
Function GetConvertImageFile(fdVl2)
    Dim objStrm, fdVl
    fdVl = ""
    If Not IsNull(fdVl2) Then
        'Convert from Binary To Text
        Set objStrm = CreateObject("ADODB.Stream")
        objStrm.open
        objStrm.Type = 1 'Binary
        objStrm.write fdVl2
        objStrm.position = 0
        objStrm.Type = 2 'Text
        fdVl = objStrm.readtext
        objStrm.Close
    End If
    GetConvertImageFile = fdVl
End Function
'AddAppointment
Sub AddAppointment(sTb, sTbKy, pat)
    Dim rst, sql, ot, cnt, hdr, adm, tot, recKy, clr, hasPrt, clSpn
    Dim lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
    Dim stf, typ, dy, sTm, eTm, sta
    Set rst = CreateObject("ADODB.Recordset")
    sql = "Select * from Appointment where Patientid='" & pat & "'"
    sql = sql & " order by AppointDate "
    cnt = 0
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            .movefirst
            hasPrt = HasPrintOutAccess(jSchd, sTb & "RCP")
            ' response.write "<tr>"

            ' response.write "<td align=""center"">"
            ' response.write "<table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""2"">"

            ' clSpn = 9
            ' response.write "<tr class=""cpHdrTr2"">"
            ' response.write "<td><u>No.</u></td>"
            ' response.write "<td><u>Staff</u></td>"
            ' response.write "<td><u>Type</u></td>"
            ' response.write "<td><u>Day</u></td>"
            ' response.write "<td><u>Start Time</u></td>"
            ' response.write "<td><u>End Time</u></td>"
            ' response.write "<td><u>Status</u></td>"
            ' response.write "</tr>"

            response.write "         <div class='tab-tbl-hld'>"
            response.write "           <div class='tab-table'>"
            response.write "             <div class='table-holder'>"
            response.write "               <table class='tbl'>"
            response.write "                 <thead class='field-h'>"
            response.write "                   <tr class='field-h'>"
            response.write "                     <th class='fh t-center'>No.</th>"
            response.write "                     <th class='fh'>Staff</th>"
            response.write "                     <th class='fh'>Type</th>"
            response.write "                     <th class='fh'>Day</th>"
            response.write "                     <th class='fh'>Start Time</th>"
            response.write "                     <th class='fh'>End Time</th>"
            response.write "                     <th class='fh'>Status</th>"
            response.write "                   </tr>"
            response.write "                 </thead>"
            response.write "                 <tbody class='field-b'>"

            Do While Not .EOF
                cnt = cnt + 1
                recKy = .fields(sTbKy)

                stf = ""
                typ = ""
                dy = ""
                sTm = ""
                eTm = ""
                sta = ""

                stf = .fields("MedicalStaffID")
                If IsNull(stf) Then
                    stf = "-"
                End If

                typ = .fields("AppointmentCatTypeID")
                If IsNull(typ) Then
                    typ = "-"
                End If

                sta = .fields("AppointmentStatusID")
                If IsNull(sta) Then
                    sta = "-"
                End If

                dy = .fields("AppointDayID")
                If IsNull(dy) Then
                    dy = "-"
                End If

                sTm = .fields("AppointStartTimeID")
                If IsNull(sTm) Then
                    sTm = "-"
                End If

                eTm = .fields("AppointEndTimeID")
                If IsNull(eTm) Then
                    eTm = "-"
                End If

                If UCase(sta) = "A002" Then
                    clr = "e8e822"
                Else
                    clr = "44ff44"
                End If
                'Clickable Url Link
                lnkUrl = "wpg" & sTb & ".asp?PageMode=ProcessSelect&" & sTbKy & "=" & recKy
                navPop = "POP"
                If hasPrt Then
                    lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=" & sTb & "RCP&PositionForTableName=" & sTb & "&" & sTb & "ID=" & recKy
                    navPop = "NAV"
                End If
                inout = "IN"
                fntSize = ""
                fntColor = clr
                bgColor = ""
                wdth = ""

                ' response.write "<tr style=""color:" & clr & """>"
                '   response.write "<td>" & CStr(cnt) & "</td>"
                response.write "                   <tr class='field-r'>"
                response.write "                     <td>" & CStr(cnt) & "</td>"

                '   'Clickable Url Link
                '   response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("MedicalStaff", stf)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("AppointmentCatType", typ)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("AppointDay", dy)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("AppointStartTime", sTm)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("AppointendTime", sTm)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("AppointmentStatus", sta)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"
                response.write "</tr>"
                .movenext
            Loop
            response.write "                 </tbody>"
            response.write "               </table>"
            response.write "             </div>"
            response.write "           </div>"
            response.write "         </div>"
            ' response.write "</table>"
            ' response.write "</td>"
            ' response.write "</tr>"
        End If
        .Close
    End With
    Set rst = Nothing
End Sub
'AddReceipt
Sub AddReceipt(sTb, sTbKy, pat)
    Dim rst, sql, ot, cnt, hdr, adm, tot, recKy, clr, hasPrt, clSpn
    Dim lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
    Dim c1, c2, c3, c4, c5
    Set rst = CreateObject("ADODB.Recordset")
    sql = "Select * from Receipt where Patientid='" & pat & "'"
    sql = sql & " order by WorkingDayID "
    cnt = 0
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            .movefirst
            hasPrt = HasPrintOutAccess(jSchd, sTb & "RCP")
            ' response.write "<tr>"

            ' response.write "<td align=""center"">"
            ' response.write "<table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""2"">"

            ' clSpn = 9
            ' response.write "<tr class=""cpHdrTr2"">"
            ' response.write "<td><u>No.</u></td>"
            ' response.write "<td><u>Receipt No.</u></td>"
            ' response.write "<td><u>Amount</u></td>"
            ' response.write "<td><u>Mode</u></td>"
            ' response.write "<td><u>Day</u></td>"
            ' 'response.write "<td><u>End Time</u></td>"
            ' response.write "<td><u>Status</u></td>"
            ' response.write "</tr>"
            response.write "         <div class='tab-tbl-hld'>"
            response.write "           <div class='tab-table'>"
            response.write "             <div class='table-holder'>"
            response.write "               <table class='tbl'>"
            response.write "                 <thead class='field-h'>"
            response.write "                   <tr class='field-h'>"
            response.write "                     <th class='fh t-center'>No.</th>"
            response.write "                     <th class='fh'>Receipt No.</th>"
            response.write "                     <th class='fh'>Amount</th>"
            response.write "                     <th class='fh'>Mode</th>"
            response.write "                     <th class='fh'>Day</th>"
            ' response.write "                     <th class='fh'>End Time</th>"
            response.write "                     <th class='fh'>Status</th>"
            response.write "                   </tr>"
            response.write "                 </thead>"
            response.write "                 <tbody class='field-b'>"

            Do While Not .EOF
                cnt = cnt + 1
                recKy = .fields(sTbKy)

                c1 = ""
                c2 = ""
                c3 = ""
                c4 = ""
                c5 = ""
                c6 = ""

                c1 = .fields("ReceiptID")
                If IsNull(c1) Then
                    c1 = "-"
                End If

                c2 = .fields("ReceiptAmount1")
                If IsNull(c2) Then
                    c2 = "-"
                End If

                c3 = .fields("PaymentModeID")
                If IsNull(c3) Then
                    c3 = "-"
                End If

                c4 = .fields("ReceiptStatusID")
                If IsNull(c4) Then
                    c4 = "-"
                End If

                c5 = .fields("WorkingDayID")
                If IsNull(c5) Then
                    c5 = "-"
                End If



                If UCase(c4) = "R001" Then
                    ' clr = "22aa22"
                    clr = "scc"
                Else
                    ' clr = "e8e822"
                    clr = "rd"
                End If
                'Clickable Url Link
                lnkUrl = "wpg" & sTb & ".asp?PageMode=ProcessSelect&" & sTbKy & "=" & recKy
                navPop = "POP"
                If hasPrt Then
                    lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=" & sTb & "RCP&PositionForTableName=" & sTb & "&" & sTb & "ID=" & recKy
                    navPop = "NAV"
                End If
                inout = "IN"
                fntSize = ""
                fntColor = clr
                bgColor = ""
                wdth = ""

                ' response.write "<tr style=""color:" & clr & """>"
                '   response.write "<td>" & CStr(cnt) & "</td>"
                response.write "                   <tr class='field-r'>"
                response.write "                      <td class='" & clr & "'>" & CStr(cnt) & "</td>"

                '   'Clickable Url Link
                '   response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = c1
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = c2
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("PaymentMode", c3)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("ReceiptStatus", c4)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("WorkingDay", c5)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                response.write "</tr>"
                .movenext
            Loop
            response.write "                 </tbody>"
            response.write "               </table>"
            response.write "             </div>"
            response.write "           </div>"
            response.write "         </div>"
            ' response.write "</table>"
            ' response.write "</td>"
            ' response.write "</tr>"
        End If
        .Close
    End With
    Set rst = Nothing
End Sub

'AddNextOfKin
Sub AddNextOfKin(sTb, sTbKy, pat)
    Dim rst, sql, ot, cnt, hdr, adm, tot, recKy, clr, hasPrt, clSpn
    Dim lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
    Dim c1, c2, c3, c4, c5
    Set rst = CreateObject("ADODB.Recordset")
    sql = "Select * from NextOfKin where Patientid='" & pat & "'"
    sql = sql & " order by entrydate desc"
    cnt = 0
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            .movefirst
            hasPrt = HasPrintOutAccess(jSchd, sTb & "RCP")
            ' response.write "<tr>"

            ' response.write "<td align=""center"">"
            ' response.write "<table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""2"">"

            ' clSpn = 9
            ' response.write "<tr class=""cpHdrTr2"">"
            ' response.write "<td><u>No.</u></td>"
            ' response.write "<td><u>Name</u></td>"
            ' response.write "<td><u>Contact</u></td>"
            ' response.write "<td><u>Relation</u></td>"
            ' response.write "<td><u>Entry Date</u></td>"
            ' response.write "</tr>"

            response.write "         <div class='tab-tbl-hld'>"
            response.write "           <div class='tab-table'>"
            response.write "             <div class='table-holder'>"
            response.write "               <table class='tbl'>"
            response.write "                 <thead class='field-h'>"
            response.write "                   <tr class='field-h'>"
            response.write "                     <th class='fh t-center'>No.</th>"
            response.write "                     <th class='fh'>Name</th>"
            response.write "                     <th class='fh'>Contact</th>"
            response.write "                     <th class='fh'>Relation</th>"
            response.write "                     <th class='fh'>Entry Date</th>"
            response.write "                   </tr>"
            response.write "                 </thead>"
            response.write "                 <tbody class='field-b'>"

            Do While Not .EOF
                cnt = cnt + 1
                recKy = .fields(sTbKy)

                c1 = ""
                c2 = ""
                c3 = ""
                c4 = ""
                c5 = ""
                c6 = ""

                c1 = .fields("NextOfKinName")
                If IsNull(c1) Then
                    c1 = "-"
                End If

                c2 = .fields("ContactAddress")
                If IsNull(c2) Then
                    c2 = "-"
                End If


                c3 = .fields("RelationTypeID")
                If IsNull(c3) Then
                    c3 = "-"
                End If

                c4 = .fields("EntryDate")
                If IsNull(c4) Then
                    c4 = "-"
                ElseIf IsDate(c4) Then
                    c4 = FormatDateDetail(c4)
                End If

                'Clickable Url Link
                lnkUrl = "wpg" & sTb & ".asp?PageMode=ProcessSelect&" & sTbKy & "=" & recKy
                navPop = "POP"
                If hasPrt Then
                    lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=" & sTb & "RCP&PositionForTableName=" & sTb & "&" & sTb & "ID=" & recKy
                    navPop = "NAV"
                End If
                inout = "IN"
                fntSize = "10"
                fntColor = ""
                bgColor = ""
                wdth = ""

                ' response.write "<tr>"
                '   response.write "<td>" & CStr(cnt) & "</td>"
                response.write "                   <tr class='field-r'>"
                response.write "                     <td>" & CStr(cnt) & "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = c1
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = c2
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("RelationType", c3)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = c4
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty bnm aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                response.write "</tr>"
                .movenext
            Loop
            ' response.write "</table>"
            ' response.write "</td>"
            ' response.write "</tr>"
            response.write "                 </tbody>"
            response.write "               </table>"
            response.write "             </div>"
            response.write "           </div>"
            response.write "         </div>"
        End If
        .Close
    End With
    Set rst = Nothing
End Sub

'AddInsuredPatient
Sub AddInsuredPatient(sTb, sTbKy, pat)
    Dim rst, sql, ot, cnt, hdr, adm, det1, dt1, tot, recKy, clr, hasPrt
    Dim lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor
    Dim spn, sch, typ, schNo, entDate, expDate, initPat, sta, clSpn
    Dim sTb2, sTbKy2, sTbNm2, wd, hasAccDp, hasAccVst
    Set rst = CreateObject("ADODB.Recordset")
    sql = "Select * from InsuredPatient where Patientid='" & pat & "'"
    sql = sql & " order by FirstDayID"
    cnt = 0
    wd = "100%"
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            .movefirst
            hasPrt = HasPrintOutAccess(jSchd, sTb & "RCP")
            hasAccDp = HasAccessRight(uName, "frmInitialDependant", "View")
            hasAccVst = HasAccessRight(uName, "frmVisitation", "View")

            response.write "         <div class='tab-tbl-hld'>"
            response.write "           <div class='tab-table h-alnp' style='max-height: ;'>"

            Do While Not .EOF
                clSpn = 9
                ' response.write "<tr>"
                ' response.write "<td align=""center"">"
                ' OpenPanelSection2
                ' response.write "<table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""2"" style=""font-size:10pt"">"
                ' response.write "<tr>"
                ' response.write "<td><u>No.</u></td>"
                ' response.write "<td><u>Sponsor</u></td>"
                ' response.write "<td><u>Scheme</u></td>"
                ' response.write "<td><u>Type</u></td>"
                ' response.write "<td><u>Scheme No.</u></td>"
                ' response.write "<td><u>Status</u></td>"
                ' response.write "<td><u>Expiry Date</u></td>"
                ' response.write "<td><u>Entry Date</u></td>"
                ' response.write "<td><u>Main Holder</u></td>"
                ' response.write "</tr>"
                response.write "             <table class='tbl-top'>"
                response.write "               <thead class='field-h'>"
                response.write "                 <tr>"
                response.write "                   <th class='fht'>No.</th>"
                response.write "                   <th class='fht'>Sponsor</th>"
                response.write "                   <th class='fht'>Scheme</th>"
                response.write "                   <th class='fht'>Type</th>"
                response.write "                   <th class='fht'>Scheme No.</th>"
                response.write "                   <th class='fht'>Status</th>"
                response.write "                   <th class='fht'>Expiry Date</th>"
                response.write "                   <th class='fht'>Entry Date</th>"
                response.write "                   <th class='fht'>Main Holder</th>"
                response.write "                 </tr>"
                response.write "               </thead>"

                cnt = cnt + 1
                recKy = .fields(sTbKy)
                spn = .fields("SponsorID")
                If IsNull(spn) Then
                    spn = "-"
                End If
                sch = .fields("InsuranceSchemeID")
                If IsNull(sch) Then
                    sch = "-"
                End If
                sta = .fields("InsuredStatusID")
                If IsNull(sta) Then
                    sta = "-"
                End If
                typ = .fields("BenefitTypeID")
                If IsNull(typ) Then
                    typ = "-"
                End If
                schNo = .fields("InsuranceNo")
                If IsNull(schNo) Then
                    schNo = "-"
                End If
                entDate = .fields("EntryDate")
                If IsNull(entDate) Then
                    entDate = ""
                End If
                If IsDate(entDate) Then
                    entDate = FormatDate(entDate)
                End If

                expDate = .fields("InsuredDate1")
                If IsNull(expDate) Then
                    expDate = ""
                End If
                If IsDate(expDate) Then
                    expDate = FormatDate(expDate)
                End If

                initPat = .fields("InitialDependantID")
                If IsNull(initPat) Then
                    initPat = "-"
                End If
                If UCase(sta) = "I001" Then
                    ' clr = "22aa22"
                    clr = "scc"
                Else
                    ' clr = "ff4444"
                    clr = "wrn"
                End If

                'Clickable Url Link
                lnkUrl = "wpg" & sTb & ".asp?PageMode=ProcessSelect&" & sTbKy & "=" & recKy
                navPop = "POP"
                If hasPrt Then
                    lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=" & sTb & "RCP&PositionForTableName=" & sTb & "&" & sTb & "ID=" & recKy
                    navPop = "NAV"
                End If
                inout = "IN"
                fntSize = "10"
                fntColor = clr
                bgColor = ""
                wdth = ""
                ' response.write "<tr style=""color:" & clr & """>"
                '   response.write "<td class=""cpHdrTd""><b>" & CStr(cnt) & "</b></td>"
                response.write "               <tbody>"
                response.write "                 <tr class='field-r'>"
                response.write "                   <td class='" & clr & "'>" & CStr(cnt) & "</td>"

                '   'Clickable Url Link
                '   response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                ' lnkText = "<b>" & GetComboName("Sponsor", spn) & "</b>"
                lnkText = GetComboName("Sponsor", spn)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, "12", fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("InsuranceScheme", sch)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("BenefitType", typ)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = schNo
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("InsuredStatus", sta)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = expDate
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = entDate
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("InitialDependant", initPat)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                     <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"
                response.write "                 </tr>"
                response.write "               </tbody>"
                response.write "             </table>"
                ' response.write "</td>"
                ' response.write "</tr>"

                'Add Visitation
                sTb2 = "Visitation"
                sTbKy2 = "VisitationID"
                sTbNm2 = "Visit / Attendance"
                If hasAccVst Then
                    ' response.write "<tr>"
                    '   response.write "<td colspan=""" & CStr(clSpn) & """>"
                    '   'OpenPanelSection
                    '     response.write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"" style=""font-size:10pt"">"
                    '       'Header
                    '       response.write "<tr>"
                    '         response.write "<td width=""20"">&nbsp;&nbsp;</td>"
                    '         response.write "<td>"
                    '           response.write "<table width=""" & wd & """ border=""0"" cellpadding=""0"" cellspacing=""0"">"
                    '             response.write "<tr class=""cpHdrTr2"">"
                    '              response.write "<td><table border=""0"" cellpadding=""2"" cellspacing=""0""><tr>"
                    '               response.write "<td class=""cpHdrTd2"">" & sTbNm2 & "</td>"

                    response.write "             <div class='table-holder tbl-aln'>"
                    response.write "               <table class='tbl'>"
                    response.write "                 <caption class='dsc t-left plr10'>"
                    response.write "                   <span class='hdr'>" & sTbNm2 & "</span>"
                    If HasAccessRight(uName, "frm" & sTb2, "New") Then
                        ' response.write "<td>"
                        ' 'Clickable Url Link
                        lnkCnt = lnkCnt + 1
                        lnkID = "lnk" & CStr(lnkCnt)
                        ' lnkText = "<b>&nbsp;&nbsp;Add New</b>"
                        lnkText = "Add New"
                        lnkUrl = "wpg" & sTb2 & ".asp?PageMode=AddNew&PullupData=" & sTbKy & "||" & recKy
                        navPop = "POP"
                        inout = "IN"
                        fntSize = "10"
                        fntColor = "#444488"
                        bgColor = ""
                        wdth = ""
                        ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                        ' response.write "</td>"
                        response.write "                   <span onclick=""openModal('" & lnkUrl & "')"" class='btsty pm'>" & lnkText & "</span>"
                    End If
                    If HasAccessRight(uName, "frm" & sTb2, "FormSearch") Then
                        ' response.write "<td>"
                        ' 'Clickable Url Link
                        lnkCnt = lnkCnt + 1
                        lnkID = "lnk" & CStr(lnkCnt)
                        ' lnkText = "<b>&nbsp;&nbsp;Search</b>"
                        lnkText = "Search"
                        lnkUrl = "wpgSrh" & sTb2 & ".asp"
                        navPop = "POP"
                        inout = "IN"
                        fntSize = "10"
                        fntColor = "#444488"
                        bgColor = ""
                        ' wdth = ""
                        ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                        ' response.write "</td>"
                        response.write "                   <span onclick=""openModal('" & lnkUrl & "')"" class='btsty pm'>" & lnkText & "</span>"
                    End If
                    response.write "                 </caption>"
                    '        response.write "</tr></table></td>"
                    '       response.write "</tr>"
                    '     response.write "</table>"
                    '   response.write "</td>"
                    ' response.write "</tr>"
                    ' 'Detail
                    AddVisitation sTb2, sTbKy2, recKy
                    response.write "                </table>"
                    response.write "              </div>"
                    '     response.write "</table>" 'Visitation
                    '     'ClosePanelSection
                    '   response.write "</td>"
                    ' response.write "</tr>"

                End If 'hasAccVst
                'Add Dependant [Parent-Child Record]
                sTb2 = "InitialDependant"
                sTbKy2 = "InitialDependantID"
                sTbNm2 = "Dependant"
                If hasAccDp Then
                    ' response.write "<tr>"
                    '   response.write "<td colspan=""" & CStr(clSpn) & """>"
                    '   'OpenPanelSection
                    '   response.write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"" style=""font-size:10pt"">"
                    '       'Header
                    '       response.write "<tr>"
                    '         response.write "<td width=""20"">&nbsp;&nbsp;</td>"
                    '         response.write "<td>"
                    '           response.write "<table width=""" & wd & """ border=""0"" cellpadding=""0"" cellspacing=""0"">"
                    '             response.write "<tr class=""cpHdrTr2"">"
                    '              response.write "<td><table border=""0"" cellpadding=""2"" cellspacing=""0""><tr>"
                    '               response.write "<td class=""cpHdrTd2"">" & sTbNm2 & "</td>"
                    response.write "             <div class='table-holder tbl-aln'>"
                    response.write "               <table class='tbl'>"
                    response.write "                 <caption class='dsc t-left plr10'>"
                    response.write "                   <span class='hdr'>" & sTbNm2 & "</span>"
                    If HasAccessRight(uName, "frm" & sTb2, "New") Then
                        ' response.write "<td>"
                        ' 'Clickable Url Link
                        lnkCnt = lnkCnt + 1
                        lnkID = "lnk" & CStr(lnkCnt)
                        ' lnkText = "<b>&nbsp;&nbsp;Add New</b>"
                        lnkText = "Add New"
                        lnkUrl = "wpg" & sTb & ".asp?PageMode=AddNew&ParentKeyData=" & sTbKy & "||" & recKy
                        navPop = "POP"
                        inout = "IN"
                        fntSize = "10"
                        fntColor = "#444488"
                        bgColor = ""
                        wdth = ""
                        ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                        ' response.write "</td>"
                        response.write "                   <span onclick=""openModal('" & lnkUrl & "')"" class='btsty pm'>" & lnkText & "</span>"
                    End If
                    If HasAccessRight(uName, "frm" & sTb, "FormSearch") Then
                        ' response.write "<td>"
                        ' 'Clickable Url Link
                        lnkCnt = lnkCnt + 1
                        lnkID = "lnk" & CStr(lnkCnt)
                        ' lnkText = "<b>&nbsp;&nbsp;Search</b>"
                        lnkText = "Search"
                        lnkUrl = "wpgSrh" & sTb & ".asp"
                        navPop = "POP"
                        inout = "IN"
                        fntSize = "10"
                        fntColor = "#444488"
                        bgColor = ""
                        wdth = ""
                        ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                        ' response.write "</td>"
                        response.write "                   <span onclick=""openModal('" & lnkUrl & "')"" class='btsty pm'>" & lnkText & "</span>"
                    End If
                    response.write "                 </caption>"
                    '        response.write "</tr></table></td>"
                    '       response.write "</tr>"
                    '     response.write "</table>"
                    '   response.write "</td>"
                    ' response.write "</tr>"
                    'Detail
                    AddDependant sTb, sTbKy, recKy
                    response.write "                </table>"
                    response.write "              </div>"
                    '     response.write "</table>" 'Dependant
                    '     'ClosePanelSection
                    '   response.write "</td>"
                    ' response.write "</tr>"
                End If 'hasAccDp
                '      response.write "<tr>"
                '        response.write "<td colspan=""" & clSpn & """ height=""10"">"
                '      response.write "</tr>"
                ' response.write "</table>"
                ' ClosePanelSection2
                ' response.write "</td>"
                ' response.write "</tr>"
                .movenext
            Loop
            response.write "            </div>"
            response.write "          </div>"
        End If
        .Close
    End With
    Set rst = Nothing
End Sub

'AddDependant
Sub AddDependant(sTb, sTbKy, initPat)
    Dim rst, sql, ot, cnt, hdr, adm, det1, dt1, tot, recKy, clr, hasPrt
    Dim lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor
    Dim spn, sch, typ, schNo, entDate, expDate, sta, clSpn
    Dim sTb2, sTbKy2, sTbNm2, wd, hasAccDp, hasAccVst
    Set rst = CreateObject("ADODB.Recordset")
    sql = "Select * from InsuredPatient where InitialDependantid='" & initPat & "'"
    sql = sql & " order by FirstDayID"
    cnt = 0
    wd = "50%"
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            .movefirst
            hasPrt = HasPrintOutAccess(jSchd, sTb & "RCP")
            ' response.write "<tr>"
            ' response.write "<td width=""20"">&nbsp;&nbsp;</td>"
            ' response.write "<td align=""center"">"
            ' response.write "<table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""2"" style=""font-size:10pt"">"
            ' clSpn = 9
            ' response.write "<tr class=""cpHdrTr2"">"
            ' response.write "<td><u>No.</u></td>"
            ' response.write "<td><u>Patient No.</u></td>"
            ' response.write "<td><u>Name</u></td>"
            ' response.write "<td><u>Relation</u></td>"
            ' response.write "<td><u>Scheme No.</u></td>"
            ' response.write "<td><u>Status</u></td>"
            ' response.write "<td><u>Expiry Date</u></td>"
            ' response.write "<td><u>Entry Date</u></td>"
            ' 'response.write "<td><u>Main Holder</u></td>"
            ' response.write "</tr>"

            response.write "                 <thead class='field-h'>"
            response.write "                   <tr class='field-h'>"
            response.write "                     <th class='fh t-center'>No.</th>"
            response.write "                     <th class='fh'>Patient No.</th>"
            response.write "                     <th class='fh'>Name</th>"
            response.write "                     <th class='fh'>Relation</th>"
            response.write "                     <th class='fh'>Scheme No.</th>"
            response.write "                     <th class='fh'>Status</th>"
            response.write "                     <th class='fh'>Expiry Date</th>"
            response.write "                     <th class='fh'>Entry Date</th>"
            response.write "                   </tr>"
            response.write "                 </thead>"
            response.write "                 <tbody class='field-b'>"

            Do While Not .EOF
                cnt = cnt + 1
                recKy = .fields(sTbKy)
                spn = .fields("PatientID")
                If IsNull(spn) Then
                    spn = "-"
                End If
                sch = .fields("InsuranceSchemeID")
                If IsNull(sch) Then
                    sch = "-"
                End If
                sta = .fields("InsuredStatusID")
                If IsNull(sta) Then
                    sta = "-"
                End If
                typ = .fields("BenefitTypeID")
                If IsNull(typ) Then
                    typ = "-"
                End If
                schNo = .fields("InsuranceNo")
                If IsNull(schNo) Then
                    schNo = "-"
                End If
                entDate = .fields("EntryDate")
                If IsNull(entDate) Then
                    entDate = ""
                End If
                If IsDate(entDate) Then
                    entDate = FormatDate(entDate)
                End If

                expDate = .fields("InsuredDate1")
                If IsNull(expDate) Then
                    expDate = ""
                End If
                If IsDate(expDate) Then
                    expDate = FormatDate(expDate)
                End If

                If UCase(sta) = "I001" Then
                    ' clr = "22aa22"
                    clr = "scc"
                Else
                    ' clr = "ff4444"
                    clr = "wrn"
                End If

                'Clickable Url Link
                lnkUrl = "wpg" & sTb & ".asp?PageMode=ProcessSelect&" & sTbKy & "=" & recKy
                If hasPrt Then
                    lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=" & sTb & "RCP&PositionForTableName=" & sTb & "&" & sTb & "ID=" & recKy
                End If
                navPop = "POP"
                inout = "IN"
                fntSize = "10"
                fntColor = clr
                bgColor = ""
                wdth = ""
                ' response.write "<tr style=""color:" & clr & """>"
                '   response.write "<td>" & CStr(cnt) & "</td>"
                response.write "                   <tr class='field-r'>"
                response.write "                      <td class='" & clr & "'>" & CStr(cnt) & "</td>"

                '   'Clickable Url Link
                '   response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = spn

                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("Patient", spn)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("BenefitType", typ)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = schNo
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("InsuredStatus", sta)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = expDate
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = entDate
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' response.write "</td>"

                response.write "</tr>"
                .movenext
            Loop
            response.write "                  </tbody>"
            ' response.write "</table>"
            ' response.write "</td>"
            ' response.write "</tr>"
        End If
        .Close
    End With
    Set rst = Nothing
End Sub
'AddVisitation
Sub AddVisitation(sTb, sTbKy, inspat)
    Dim rst, sql, ot, cnt, hdr, adm, det1, dt1, tot, recKy, clr, hasPrt
    Dim lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor
    Dim c1, c2, c3, c4, c5, c6, c7, clSpn
    Dim sTb2, sTbKy2, sTbNm2, wd, hasAccDp, hasAccVst
    Set rst = CreateObject("ADODB.Recordset")
    sql = "Select * from Visitation where InsuredPatientid='" & inspat & "'"
    sql = sql & " order by visitDate desc"
    cnt = 0
    wd = "50%"
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            .movefirst
            hasPrt = HasPrintOutAccess(jSchd, sTb & "RCP")
            ' response.write "<tr>"
            ' response.write "<td width=""20"">&nbsp;&nbsp;</td>"
            ' response.write "<td align=""center"">"
            ' response.write "<table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""2"" style=""font-size:10pt"">"
            ' clSpn = 9
            ' response.write "<tr class=""cpHdrTr2"">"
            ' response.write "<td><u>No.</u></td>"
            ' response.write "<td><u>Visit No.</u></td>"
            ' response.write "<td><u>Consult Type</u></td>"
            ' response.write "<td><u>Doctor</u></td>"
            ' response.write "<td><u>Type</u></td>"
            ' response.write "<td><u>Status</u></td>"
            ' response.write "<td><u>Fee</u></td>"
            ' response.write "<td><u>Visit Date</u></td>"
            ' response.write "</tr>"

            response.write "                 <thead class='field-h'>"
            response.write "                   <tr class='field-h'>"
            response.write "                     <th class='fh t-center'>No.</th>"
            response.write "                     <th class='fh'>Visit No.</th>"
            response.write "                     <th class='fh'>Consult Type</th>"
            response.write "                     <th class='fh'>Doctor</th>"
            response.write "                     <th class='fh'>Type</th>"
            response.write "                     <th class='fh'>Status</th>"
            response.write "                     <th class='fh t-right'>Fee</th>"
            response.write "                     <th class='fh'>Visit Date</th>"
            response.write "                   </tr>"
            response.write "                 </thead>"
            response.write "                 <tbody class='field-b'>"

            Do While Not .EOF
                cnt = cnt + 1
                recKy = .fields(sTbKy)
                c1 = ""
                c2 = ""
                c3 = ""
                c4 = ""
                c5 = ""
                c6 = ""

                c1 = .fields("VisitationID")
                If IsNull(c1) Then
                    c1 = "-"
                End If


                c2 = .fields("SpecialistTypeID")
                If IsNull(c2) Then
                    c2 = "-"
                End If

                c3 = .fields("SpecialistID")
                If IsNull(c3) Then
                    c3 = "-"
                End If

                c4 = .fields("VisitTypeID")
                If IsNull(c4) Then
                    c4 = "-"
                End If

                c5 = .fields("VisitStatusID")
                If IsNull(c5) Then
                    c5 = "-"
                End If

                c6 = .fields("VisitCost")
                If IsNull(c6) Then
                    c6 = "-"
                End If

                c7 = .fields("VisitDate")
                If IsNull(c7) Then
                    c7 = ""
                End If
                If IsDate(c7) Then
                    c7 = FormatDate(c7)
                End If

                If UCase(c5) = "V001" Then
                    ' clr = "#ff4444"
                    clr = "wrn"
                ElseIf UCase(c5) = "V002" Then
                    ' clr = "e8e822"
                    clr = "rd"
                ElseIf UCase(c5) = "V007" Then
                    ' clr = "e8e822"
                    clr = "rd"
                ElseIf UCase(c5) = "V003" Then
                    ' clr = "#44ff44"
                    clr = "scc"
                ElseIf UCase(c5) = "V009" Then
                    ' clr = "#aa44ff"
                    clr = "bnm"
                ElseIf UCase(c5) = "V012" Then
                    ' clr = "#44ff44"
                    clr = "scc"
                End If

                'Clickable Url Link

                lnkUrl = "wpg" & sTb & ".asp?PageMode=ProcessSelect&" & sTbKy & "=" & recKy
                navPop = "POP"
                If hasPrt Then
                    lnkUrl = "wpgPrtPrintLayoutAll.asp?PrintLayoutName=" & sTb & "RCP&PositionForTableName=" & sTb & "&" & sTb & "ID=" & recKy
                    navPop = "NAV"
                End If
                inout = "IN"
                fntSize = "10"
                fntColor = clr
                bgColor = ""
                wdth = ""

                response.write "                   <tr class='field-r'>"
                response.write "                      <td class='" & clr & "'>" & CStr(cnt) & "</td>"

                ' response.write "<tr style=""color:" & clr & """>"
                '   response.write "<td>" & CStr(cnt) & "</td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = c1
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("SpecialistType", c2)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("Specialist", c3)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("VisitType", c4)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = GetComboName("VisitStatus", c5)
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = c6
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td class='t-right'><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                ' 'Clickable Url Link
                ' response.write "<td>"
                lnkCnt = lnkCnt + 1
                lnkID = "lnk" & CStr(lnkCnt)
                lnkText = c7
                ' AddUrlLink lnkID, lnkText, lnkUrl, navPop, inout, fntSize, fntColor, bgColor, wdth
                ' response.write "</td>"
                response.write "                       <td><span onclick=""openModal('" & lnkUrl & "')"" class='btsty " & clr & " aln'>" & lnkText & "</span></td>"

                response.write "</tr>"
                .movenext
            Loop
            response.write "                  </tbody>"
            ' response.write "</table>"
            ' response.write "</td>"
            ' response.write "</tr>"
        End If
        .Close
    End With
    Set rst = Nothing
End Sub
Sub OpenPanelSection()
    Dim sz, dm, pfx
    sz = "20"
    pfx = "S004"
    dm = "width=""" & sz & """ height=""" & sz & """"
    response.write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">"
    response.write "<tr>"
    response.write "<td " & dm & " ><img " & dm & " src=""images/style/" & pfx & "11.gif""></td>"
    response.write "<td style=""background:url('images/style/" & pfx & "12.gif') 0 0 repeat""></td>"
    response.write "<td " & dm & "><img " & dm & " src=""images/style/" & pfx & "13.gif""></td>"
    response.write "</tr>"
    response.write "<tr>"
    response.write "<td style=""background:url('images/style/" & pfx & "21.gif') 0 0 repeat""></td>"
    response.write "<td width=""100%"">"
End Sub
Sub ClosePanelSection()
    Dim sz, dm, pfx
    sz = "20"
    pfx = "S004"
    dm = "width=""" & sz & """ height=""" & sz & """"
    response.write "</td>"
    response.write "<td style=""background:url('images/style/" & pfx & "23.gif') 0 0 repeat""></td>"
    response.write "</tr>"
    response.write "<tr>"
    response.write "<td " & dm & "><img " & dm & " src=""images/style/" & pfx & "31.gif""></td>"
    response.write "<td style=""background:url('images/style/" & pfx & "32.gif') 0 0 repeat""></td>"
    response.write "<td " & dm & "><img " & dm & " src=""images/style/" & pfx & "33.gif""></td>"
    response.write "</tr>"
    response.write "</table>"
End Sub
Sub OpenPanelSection2()
    Dim sz, dm, pfx
    sz = "15"
    pfx = "S003"
    dm = "width=""" & sz & """ height=""" & sz & """"
    response.write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">"
    response.write "<tr>"
    response.write "<td " & dm & " ><img " & dm & " src=""images/style/" & pfx & "11.gif""></td>"
    response.write "<td style=""background:url('images/style/" & pfx & "12.gif') 0 0 repeat""></td>"
    response.write "<td " & dm & "><img " & dm & " src=""images/style/" & pfx & "13.gif""></td>"
    response.write "</tr>"
    response.write "<tr>"
    response.write "<td style=""background:url('images/style/" & pfx & "21.gif') 0 0 repeat""></td>"
    response.write "<td align=""left"">"
End Sub
Sub ClosePanelSection2()
    Dim sz, dm, pfx
    sz = "15"
    pfx = "S003"
    dm = "width=""" & sz & """ height=""" & sz & """"
    response.write "</td>"
    response.write "<td style=""background:url('images/style/" & pfx & "23.gif') 0 0 repeat""></td>"
    response.write "</tr>"
    response.write "<tr>"
    response.write "<td " & dm & "><img " & dm & " src=""images/style/" & pfx & "31.gif""></td>"
    response.write "<td style=""background:url('images/style/" & pfx & "32.gif') 0 0 repeat""></td>"
    response.write "<td " & dm & "><img " & dm & " src=""images/style/" & pfx & "33.gif""></td>"
    response.write "</tr>"
    response.write "</table>"
End Sub
Function HasPrintOutAccess(jb, prt)
    Dim rstTblSql, sql, ot
    ot = False
    Set rstTblSql = CreateObject("ADODB.Recordset")
    With rstTblSql
        sql = "Select JobScheduleID from printoutalloc "
        sql = sql & " where printlayoutid='" & prt & "' And jobscheduleid='" & jb & "'"
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            .movefirst
            ot = True
        End If
        .Close
    End With
    HasPrintOutAccess = ot
    Set rstTblSql = Nothing
End Function
Function getPatientRecCtrlSect(strPatientID)

    Dim str
    str = ""

    Dim strPatietnInfo, strBillingAcs, strReceipts

    strPatietnInfo = getPatientInfoCtrlSect(strPatientID)
    strBillingAcs = getBillingAccCtrlSect(strPatientID)
    strReceipts = getRecentReceiptsCtrlSect(strPatientID, 0)

    str = "" & _
    "<div class='patientrec ctrl-sect'>" & _
    strPatietnInfo & _
    strBillingAcs & _
    strReceipts & _
    "</div>"

    getPatientRecCtrlSect = str

End Function


Function getVisitRecCtrlSect(strVisitationID)


    Dim str

    str = ""

    Dim strPatietnInfo, strVisitDetails, strDiagnoses
    Dim strServices

    strPatietnInfo = getPatientInfoCtrlSect(strPatientID)
    strVisitDetails = getVisitInfoCtrlSect(strVisitationID)
    strDiagnoses = getDiagnosisCtrlSect(strVisitationID)
    strServices = getServicesCtrlSect(strVisitationID)

    'strLabTests = getLabTestCtrlSect(strVisitationID)
    strLabTests = getLabTestCtrlSect("V5150526011")

    'strDispensaries = getDispensariesCtrlSect("V9141124145")
    strDispensaries = getDispensariesCtrlSect("V4140905001")

    str = "" & _
    "<div class='visitrec ctrl-sect'>" & _
    strPatietnInfo & _
    "<table class='stripped bordered'>" & _
    "<tbody>" & _
    "<tr><td class='visit-Label'>Visit Details</td><td class='visit-info'>" & strVisitDetails & "</td></tr>" & _
    "<tr><td class='diagnosis-Label'>Diagnoses</td><td class='diagnosis-info'>" & strDiagnoses & "</td></tr>" & _
    "<tr><td class='services-Label'>Services/Treatments</td><td class='services-info'>" & strServices & "</td></tr>" & _
    "<tr><td class='labtest-Label'>Lab Tests</td><td class='labtest-info'>" & strLabTests & "</td></tr>" & _
    "<tr><td class='dispensaries-Label'>Dispensaries</td><td class='dispensaries-info'>" & strDispensaries & "</td></tr>" & _
    "<tr><td class='admissions-Label'>Admissions</td><td class='admissions-info'></td></tr>" & _
    "</body>" & _
    "</table>" & _
    "</div>"

    getVisitRecCtrlSect = str


End Function

Function getVisitInfoCtrlSect(strVisitationID)

    Dim str
    str = ""

    Dim rst, sql

    Set rst = Nothing
    sql = "Select * from visitation where visitationID = '" & strVisitationID & "' "

    Dim strSpecialistTypeName, strVisitDate, strInsuranceSchemeName

    If readNextRow(rst, sql) Then

        strVisitationID = rst.fields("VisitationID")
        strSpecialistTypeName = GetComboName("SpecialistType", rst.fields("SpecialistTypeID"))
        strVisitDate = rst.fields("VisitDate")
        strInsuranceSchemeName = GetComboName("InsuranceScheme", rst.fields("InsuranceSchemeID"))

        str = "" & _
        "<div class='visit ctrl-sect'>" & _
        "<span class='info-span'>" & _
        "Visit ID: <strong>" & strVisitationID & "</strong>" & _
        "</span>" & _
        "<span class='info-span'>" & _
        "Type: <strong>" & strSpecialistTypeName & "</strong>" & _
        "</span>" & _
        "<span class='info-span'>" & _
        "Date: <strong>" & FormatDate(strVisitDate) & "</strong>" & _
        "</span>" & _
        "<br/>" & _
        "<span class='info-span'>" & _
        "Account: <strong>" & strInsuranceSchemeName & "</strong>" & _
        "</span>" & _
        "</div>"

    End If

    getVisitInfoCtrlSect = str

End Function


Function getMedicalInfoSect()

    Dim str

    strPatietnInfo = getPatientInfoCtrlSect()
    'strConsultations = getConsultationCtrlSect()

    str = "" & _
    "<div class='medicalinfo ctrl-sect'>" & _
    strPatietnInfo & _
    strConsultations & _
    "</div>"

    getMedicalInfoSect = str

End Function




'*********** subs sections ************* '

Function getPatientInfoCtrlSect(strPatientID)

    Dim str
    str = ""

    Dim rst, sql
    Set rst = Nothing
    sql = "Select * from patient where patientID = '" & strPatientID & "'"

    If readNextRow(rst, sql) Then

        Dim strPatientName, strGender, strAge, strBirthDate

        strPatientName = rst.fields("PatientName")
        strGender = GetComboName("Gender", rst.fields("GenderID"))
        strAge = rst.fields("Age")
        strBirthDate = rst.fields("BirthDate")

        Dim hrefa

        hrefa = makeWinOpenHref("wpgPatient.asp?pageMode=processSelect&patientID=" & strPatientID)

        str = "" & _
        "<div class='patientinfo ctrl-sect'>" & _
        "<div class='name'>" & strPatientName & "</div>" & _
        "<p>" & _
        "<span class='info-span'>Patient ID: " & _
        "<strong>" & strPatientID & "</strong>" & _
        "</span>" & _
        "<span class='info-span'>Gender: " & _
        "<strong>" & strGender & "</strong>" & _
        "</span>" & _
        "<span class='info-span'>Age: " & _
        "<strong>" & strAge & "yrs</strong>" & _
        "</span>" & _
        "<span class='info-span'>DOB: " & _
        "<strong>" & FormatDate(strBirthDate) & "</strong>" & _
        "</span>" & _
        "<span class='info-span'><a class='vlink' " & hrefa & ">[View Details]</a>" & _
        "</span>" & _
        "</p>" & _
        "</div>"

    End If

    getPatientInfoCtrlSect = str

End Function

Function makeWinOpenHref(strUrl)
    Dim href
    href = "href=""javascript:void(0)"" onclick=""window.open('" & strUrl & "', 'menubar=no,toolbar=no');"" "
    makeWinOpenHref = href

End Function


Function getBillingAccCtrlSect(strPatientID)

    Dim str
    str = ""


    Dim rst, sql

    Set rst = Nothing
    sql = "Select * from insuredPatient where patientID = '" & strPatientID & "' "

    Dim i
    i = 0

    Dim strInsuredPatientID, strInsuranceSchemeName
    Dim strBenefitOption, strInsuredStatusName, strVisits

    strInsuredPatientID = ""
    strInsuranceSchemeName = ""
    strBenefitOption = ""
    strInsuredStatusName = ""
    strVisits = ""

    Do While readNextRow(rst, sql)
        i = i + 1

        strInsuredPatientID = rst.fields("InsuredPatientID")
        strInsuranceSchemeName = GetComboName("InsuranceScheme", rst.fields("InsuranceSchemeID"))
        strBenefitOption = rst.fields("InsuredInfo1")
        strInsuredStatusName = GetComboName("InsuredStatus", rst.fields("InsuredStatusID"))

        strVisits = getRecentVisitsCtrlSect(strPatientID, strInsuredPatientID, 3)

        str = str & _
        "<tr>" & _
        "<td class='no'>" & CStr(i) & "</td>" & _
        "<td class='account'>" & _
        "<nobr><span class='info-span'>" & _
        "A/C No: <strong>" & strInsuredPatientID & "</strong>" & _
        "</span></nobr>" & _
        "<a class='asbtn' href='#'>View</a>" & _
        "<div class='name'>" & strInsuranceSchemeName & "</div>" & _
        "<nobr><span class='info-span'>" & _
        "Option: <strong>" & strBenefitOption & "</strong>" & _
        "</span>" & _
        "<span class='info-span'>" & _
        "Status <strong class='color-green'>" & strInsuredStatusName & "</strong>" & _
        "</span></nobr>" & _
        "</td>" & _
        "<td class='visits'>" & strVisits & "</td>" & _
        "</tr>"
    Loop


    If Trim(str) = "" Then
        str = "<p class='norecs'>No Accounts Found</p>"
    Else
        str = "" & _
        "<table class='accounts'>" & _
        "<tbody>" & _
        "<tr>" & _
        "<th>No.</th>" & _
        "<th class='account'>Accounts</th>" & _
        "<th class='visits'>Recent Visits</th>" & _
        "</tr>" & _
        str & _
        "</tbody>" & _
        "</table>"
    End If

    str = "" & _
    "<div class='billingaccounts ctrl-sect'>" & _
    "<div class='ctrl-sect-heading'>" & _
    "<div>Billing Accounts <a class='asbtn flt-right' href='#'>Add New Account</a></div>" & _
    "</div>" & _
    str & _
    "</div>"

    getBillingAccCtrlSect = str

End Function

Function getRecentVisitsCtrlSect(strPatientID, strInsuredPatientID, iLimit)

    Dim str
    str = ""

    If iLimit = 0 Then
        iLimit = 3 'default
    End If

    Dim rst, sql

    Set rst = Nothing
    sql = "Select top " & iLimit & " * from visitation where 1 = 1 "
    If Trim(strPatientID) Then
        sql = sql & " And patientID = '" & strPatientID & "' "
    End If

    If Trim(strInsuredPatientID) <> "" Then
        sql = sql & " And InsuredPatientID = '" & strInsuredPatientID & "' "
    End If

    sql = sql & " order by visitDate desc "

    Dim strVisitationID, strVisitDate, strSpecialistTypeName, strBranchName

    strVisitationID = ""
    strVisitDate = ""
    strSpecialistTypeName = ""
    strBranchName = ""

    Dim i
    i = 0

    Do While readNextRow(rst, sql)
        i = i + 1

        strVisitationID = rst.fields("VisitationID")
        strVisitDate = rst.fields("VisitDate")
        strSpecialistTypeName = GetComboName("SpecialistType", rst.fields("SpecialistTypeID"))
        strBranchName = GetComboName("Branch", rst.fields("BranchID"))

        str = str & _
        "<tr>" & _
        "<td class='no'>" & CStr(i) & "</td>" & _
        "<td class='visitno'>" & strVisitationID & "</td>" & _
        "<td class='date'>" & FormatDate(strVisitDate) & "</td>" & _
        "<td class='type'>" & strSpecialistTypeName & "</td>" & _
        "<td class='branch'>" & strBranchName & "</td>" & _
        "<td class=''><a class='asbtn' href='#'>View</a></td>" & _
        "</tr>"

    Loop

    If Trim(str) <> "" Then

        str = "" & _
        "<table class='accounts stripped bordered'>" & _
        "<tbody>" & _
        "<tr>" & _
        "<th>No.</th>" & _
        "<th class='no'>Visit No.</th>" & _
        "<th class='date'>Date</th>" & _
        "<th class='type'>Type</th>" & _
        "<th class='branch'>Branch</th>" & _
        "<th class=''>&nbsp;</th>" & _
        "</tr>" & _
        str & _
        "</tbody>" & _
        "</table>"
    Else
        str = "<p class='norecs'>No Visits Found</p>"
    End If

    str = "" & _
    "<div class='visits ctrl-sect'>" & _
    str & _
    "<div class='text-right'>" & _
    "<a class='asbtn' href='#'>View All Visits</a> " & _
    "<a class='asbtn' href='#'>ADD VISIT</a>" & _
    "</div>" & _
    "</div>"

    getRecentVisitsCtrlSect = str

End Function

Function getRecentReceiptsCtrlSect(strPatientID, iLimit)

    Dim str
    str = ""

    If iLimit = 0 Then
        iLimit = 5 ' default
    End If

    Dim strReceiptID, strReceiptDate, strAmount, strDescription

    Dim rst, sql

    sql = "Select top " & iLimit & " * from Receipt where patientID = '" & strPatientID & "' order by ReceiptDate desc "
    Set rst = Nothing

    Dim i
    i = 0

    Do While readNextRow(rst, sql)

        i = i + 1

        strReceiptID = rst.fields("ReceiptID")
        strReceiptDate = rst.fields("ReceiptDate")
        strAmount = rst.fields("ReceiptAmount1")
        strDescription = rst.fields("Remarks")

        str = str & _
        "<tr>" & _
        "<td>" & CStr(i) & "</td>" & _
        "<td class='no'>" & strReceiptID & "</td>" & _
        "<td class='date'>" & FormatDate(strReceiptDate) & "</td>" & _
        "<td class='amount text-right'>" & FormatNumber(strAmount, 2, , , -1) & "</td>" & _
        "<td class='desc'>" & strDescription & "</td>" & _
        "<td class=''><a class='asbtn' href='#'>View</a></td>" & _
        "</tr>"
    Loop

    If Trim(str) = "" Then
        str = "<p class='norecs'>No Receipts Found</p>"
    Else

        str = "" & _
        "<table class='receipts stripped bordered'>" & _
        "<tbody>" & _
        "<tr>" & _
        "<th>No.</th>" & _
        "<th class='no'>Receipt No.</th>" & _
        "<th class='date'>Date</th>" & _
        "<th class='amount text-right'>Amount</th>" & _
        "<th class='desc'>Description</th>" & _
        "<th class=''>&nbsp;</th>" & _
        "</tr>" & _
        str & _
        "</tbody>" & _
        "</table>"

    End If


    str = "" & _
    "<div class='receipts ctrl-sect'>" & _
    "<div class='ctrl-sect-heading'>" & _
    "<div>Payments/Receipts <a class='asbtn flt-right' href='#'>Add New Receipt</a></div>" & _
    "</div>" & _
    str & _
    "<div class='text-right'>" & _
    "<a class='asbtn' href='#'>View All Receipts</a>" & _
    "</div>" & _
    "</div>"

    getRecentReceiptsCtrlSect = str

End Function


Function getDiagnosisCtrlSect(strVisitationID)

    Dim str, strDs

    str = ""
    strDs = ""

    Dim rst, rst2, sql, i

    Set rst = Nothing
    sql = "Select * from consultReview where visitationID = '" & strVisitationID & "' order by consultReviewID "

    Do While readNextRow(rst, sql)

        Set rst2 = Nothing

        sql = "" & _
        "Select distinct d.diseaseName  " & _
        "from disease As d " & _
        "right join diagnosis As dg on dg.diseaseID = d.diseaseID " & _
        "where dg.consultReviewID = '" & rst.fields("consultReviewID") & "' " & _
        "order by d.diseaseName "

        strDs = ""
        i = 0

        Do While readNextRow(rst2, sql)
            i = i + 1
            strDs = strDs & "<li>(" & CStr(i) & ") " & rst2.fields("diseaseName") & "</li> "
        Loop

        If Trim(strDs) <> "" Then

            If Trim(str) <> "" Then
                str = str & "<div class='rule'>&nbsp;</div>" 'add rule If multiple consultReviews'
            End If

            str = str & _
            "<div style='display:table; width:100%'>" & _
            "<a class='asbtn flt-right' href='#'>Add/Edit</a>" & _
            "<ol class='info-list'>" & strDs & "</ol>" & _
            "</div>"
        End If

    Loop

    If Trim(str) = "" Then

        'todo:
        ' add/edit diagnosis link based on rst.recordcount
        'If count > 0, edit last review Else add New review
        str = "<p class='norecs'>No Diagnoses Found</p>"
        str = str & "<div class='text-right'><a class='asbtn' href='#'>Add/Edit Diagnosis</a></div>"
    End If

    str = "<div class='diagnosis ctrl-sect'>" & str & "</div>"

    getDiagnosisCtrlSect = str

End Function

Function getServicesCtrlSect(strVisitationID)

    Dim str, strDs

    str = ""
    strDs = ""

    Dim rst, rst2, sql, i

    Set rst = Nothing
    sql = "Select * from consultReview where visitationID = '" & strVisitationID & "' order by consultReviewID "

    Do While readNextRow(rst, sql)

        Set rst2 = Nothing

        sql = "" & _
        "Select distinct t.treatmentName  " & _
        "from treatment As t " & _
        "right join treatCharges As tc on tc.treatmentID = t.treatmentID " & _
        "where tc.consultReviewID = '" & rst.fields("consultReviewID") & "' " & _
        "order by t.treatmentName "

        strDs = ""
        i = 0

        Do While readNextRow(rst2, sql)
            i = i + 1
            strDs = strDs & "<li>(" & CStr(i) & ") " & rst2.fields("treatmentName") & "</li> "
        Loop

        If Trim(strDs) <> "" Then

            If Trim(str) <> "" Then
                str = str & "<div class='rule'>&nbsp;</div>" 'add rule If multiple consultReviews'
            End If

            str = str & _
            "<div style='display:table; width:100%'>" & _
            "<a class='asbtn flt-right' href='#'>Add/Edit</a>" & _
            "<ol class='info-list'>" & strDs & "</ol>" & _
            "</div>"
        End If

    Loop

    If Trim(str) = "" Then

        'todo:
        ' add/edit diagnosis link based on rst.recordcount
        'If count > 0, edit last review Else add New review
        str = "<p class='norecs'>No Services Found</p>"
        str = str & "<div class='text-right'><a class='asbtn' href='#'>Add/Edit Service</a></div>"
    End If

    str = "<div class='services ctrl-sect'>" & str & "</div>"

    getServicesCtrlSect = str

End Function


Function getLabTestCtrlSect(strVisitationID)

    Dim str, strDs

    str = ""
    strDs = ""

    Dim rst, rst2, sql, i

    Set rst = Nothing
    sql = "Select * from labRequest where visitationID = '" & strVisitationID & "' order by labRequestID "

    Do While readNextRow(rst, sql)

        Set rst2 = Nothing

        sql = "" & _
        "Select r.labRequestID, lt.labTestID, lt.labTestName  " & _
        "from labResults As r " & _
        "left join labTest As lt on lt.labTestID = r.labTestID " & _
        "where r.labRequestID = '" & rst.fields("labRequestID") & "' " & _
        "group by r.labRequestID, lt.labTestID, lt.labTestName " & _
        "order by lt.labTestName "

        strDs = ""
        i = 0

        Do While readNextRow(rst2, sql)
            i = i + 1
            strDs = strDs & _
            "<li>" & _
            "(" & CStr(i) & ") " & rst2.fields("labTestName") & _
            " <a class='vlink' href='#''>[View Results]</a>" & _
            "</li> "
        Loop

        If Trim(strDs) <> "" Then

            If Trim(str) <> "" Then
                str = str & "<div class='rule'>&nbsp;</div>" 'add rule If multiple requests
            End If

            str = str & _
            "<div style='display:table; width:100%'>" & _
            "<span class='info-span'>Path No: <strong>" & rst.fields("labRequestID") & "</strong></span>" & _
            "<a class='asbtn flt-right' href='#'>View</a>" & _
            "<ol class='info-list'>" & strDs & "</ol>" & _
            "</div>"
        End If

    Loop

    If Trim(str) = "" Then
        str = "<p class='norecs'>No Lab Tests Found</p>"
    End If

    str = "<div class='services ctrl-sect'>" & _
    str & _
    "<div class='rule'>&nbsp;</div>" & _
    "<div class='text-right'><a class='asbtn' href='#'>Add New Lab Test</a></div>" & _
    "</div>"

    getLabTestCtrlSect = str

End Function


Function getDispensariesCtrlSect(strVisitationID)

    Dim str, strDs

    str = ""
    strDs = ""

    Dim rst, rst2, sql, i

    Set rst = Nothing
    sql = "Select * from drugSale where visitationID = '" & strVisitationID & "' order by drugSaleID "

    Do While readNextRow(rst, sql)

        Set rst2 = Nothing

        sql = "" & _
        "Select dsi.drugSaleID, dsi.drugID, d.drugName " & _
        "from drugSaleItems As dsi " & _
        "left join drug As d on d.drugID = dsi.drugID " & _
        "where dsi.drugSaleID = '" & rst.fields("drugSaleID") & "' " & _
        "group by dsi.drugSaleID, dsi.drugID, d.drugName " & _
        "order by d.drugName "

        strDs = ""
        i = 0

        Do While readNextRow(rst2, sql)
            i = i + 1
            strDs = strDs & _
            "<li>(" & CStr(i) & ") " & rst2.fields("drugName") & "</li> "
        Loop

        If Trim(strDs) <> "" Then

            If Trim(str) <> "" Then
                str = str & "<div class='rule'>&nbsp;</div>" 'add rule If multiple sales
            End If

            str = str & _
            "<div style='display:table; width:100%'>" & _
            "<span class='info-span'>Dispensary ID: <strong>" & rst.fields("drugSaleID") & "</strong></span>" & _
            "<a class='asbtn flt-right' href='#'>View</a>" & _
            "<ol class='info-list'>" & strDs & "</ol>" & _
            "</div>"
        End If

    Loop

    If Trim(str) = "" Then
        str = "<p class='norecs'>No Dispensaries Found</p>"
    End If

    str = "<div class='dispensaries ctrl-sect'>" & _
    str & _
    "<div class='rule'>&nbsp;</div>" & _
    "<div class='text-right'><a class='asbtn' href='#'>Add New Dispensary</a></div>" & _
    "</div>"

    getDispensariesCtrlSect = str

End Function

Function getCSS()

    Dim str

    str = "" & _
    ".ctrl-sect { font-size: 0.95em; margin-bottom: 1em; color: #333; }" & _
    ".ctrl-sect .text-right { text-align: right; }" & _
    ".ctrl-sect .flt-right { float: right; }" & _
    ".ctrl-sect .ctrl-sect-heading { background: #F2F2F2; border-radius: 6px; display: table; margin-bottom: 5px; width: 100%; }" & _
    ".ctrl-sect .ctrl-sect-heading div { margin: 6px 8px; }" & _
    ".ctrl-sect .ctrl-sect-heading div a.flt-right { float: right; margin-right: 0px; border: 1px solid #FFF; }" & _
    ".ctrl-sect .Sub-heading { font-size: 0.85em; }" & _
    ".ctrl-sect a { color: blue; }"

    str = str & _
    ".ctrl-sect a.asbtn { text-decoration: none; color: #333; background: #eaeaea; padding: 2px 8px; font-size: 11px; border-radius: 6px; }" & _
    ".ctrl-sect a.asbtn:hover { background: #d1d1d1; }" & _
    ".ctrl-sect div.rule { border-bottom: 1px dotted #CCC !important; font-size: 1px; margin: 12px 0; }" & _
    ".ctrl-sect tr td, .ctrl-sect tr th { text-align: left; vertical-align: top; padding: 6px 12px; font-size: 1em; }" & _
    ".ctrl-sect tr.rule td { font-size: 1px; line-height: 1px; }" & _
    ".ctrl-sect .info-span { margin-right: 10px; font-size: 1em; line-height: 1.5em; }" & _
    ".ctrl-sect .info-span strong { font-size: 1em; }" & _
    ".ctrl-sect a.vlink { color: green; font-size: 11px; text-decoration: none; }" & _
    ".ctrl-sect a.vlink:hover { color: red; text-decoration: underline; }" & _
    ".ctrl-sect ol.info-list { margin: 5px 0px; padding: 0; list-style-type: decimal; }" & _
    ".ctrl-sect ol.info-list li { display: inline; margin-right: 10px; white-space: nowrap; }" & _
    ".ctrl-sect table { width: 100%; font-size: 0.9em; margin-bottom: 5px; }" & _
    ".ctrl-sect table.stripped th { background: #d8d8d8; }" & _
    ".ctrl-sect table.stripped tr:nth-child(even) td { background-color: #f0f0ff; }" & _
    ".ctrl-sect table.bordered td { border-bottom: 1px solid #f2f2f2; }" & _
    ".ctrl-sect.billingaccounts table.accounts { margin-top: 10px; }"
    str = str & _
    ".ctrl-sect.billingaccounts table.accounts th { padding-top: 2px; padding-bottom: 2px; font-size: 0.9em; }" & _
    ".ctrl-sect.billingaccounts table.accounts td.account { min-width: 160px; line-height: 1.4em; }" & _
    ".ctrl-sect.billingaccounts table.accounts td.account div.name { font-size: 1.2em; margin-bottom: 4px; color: green; }" & _
    ".ctrl-sect.billingaccounts table.accounts td.account span.info-span { font-size: 0.85em; }" & _
    ".ctrl-sect.billingaccounts table.accounts td.visits td { padding-top: 2px; padding-bottom: 2px; }" & _
    ".ctrl-sect.billingaccounts table.accounts td.visits td.branch, .ctrl-sect.billingaccounts table.accounts td.visits td.date { white-space: nowrap; }" & _
    ".ctrl-sect.dispensaries ol.dispensaries-list { padding-top: 0; }" & _
    ".ctrl-sect.dispensaries ol.dispensaries-list ol.info-list { margin-top: -16px; }" & _
    ".ctrl-sect.patientinfo { padding: 1em; background: ivory; margin: 8px 0; border-radius: 6px; border: 1px solid #EAEAEA; }" & _
    ".ctrl-sect.patientinfo div.name { margin: 0 0 5px 0; font-size: 1.3em; font-weight: bold; }" & _
    ".ctrl-sect.patientinfo p { padding: 0; margin: 0; font-size: 0.92em; }"

    getCSS = str

End Function


' **************** helpers ************************* '

Function readNextRow(ByRef aRecordSet, ByVal sql)

    If IsEmpty(aRecordSet) Then
        Set aRecordSet = Nothing
    End If

    If aRecordSet Is Nothing Then

        Set aRecordSet = CreateObject("ADODB.Recordset")
        aRecordSet.open qryPro.FltQry(sql), conn, 3, 4

        If aRecordSet.RecordCount > 0 Then
            aRecordSet.movefirst
            readNextRow = Not aRecordSet.EOF
        Else
            readNextRow = False
        End If

    Else

        If aRecordSet.EOF Then
            readNextRow = False
        Else
            aRecordSet.movenext
            readNextRow = Not aRecordSet.EOF
        End If

    End If

End Function

' date related functions '

Function getNoOfDaysInMonth(aDate)

    Dim noOfDays

    noOfDays = 0

    If IsDate(aDate) Then
        noOfDays = DateSerial(Year(aDate), month(aDate) + 1, 1) - DateSerial(Year(aDate), month(aDate), 1)
    End If

    getNoOfDaysInMonth = noOfDays

End Function

Function getDateFromID(strDateID, strType)

    Dim ot

    Dim y, m, d, h, n, s

    ot = ""

    If strType = "day" Then
        y = Mid(strDateID, 4, 4)
        m = Mid(strDateID, 8, 2)
        d = Mid(strDateID, 10, 2)
        ot = m & "/" & d & "/" & y
    End If

    If strType = "month" Then
        y = Mid(strDateID, 4, 4)
        m = Mid(strDateID, 8, 2)
        d = 1
        ot = m & "/" & d & "/" & y
    End If

    If strType = "year" Then
        y = Mid(strDateID, 4, 4)
        m = 1
        d = 1
        ot = m & "/" & d & "/" & y
    End If

    getDateFromID = ot

End Function

Function valOrEmpty(val)

    valOrEmpty = "&nbsp;"

    If IsNumeric(val) Then
        If CDbl(val) > 0 Then
            valOrEmpty = CStr(val)
        End If

    Else

        If IsNull(val) Then

         Exit Function

        End If

        If Trim(CStr(val)) <> "" Then
            valOrEmpty = Trim(CStr(val))
        End If

    End If

End Function

Function makeDatePeriod(strDateStart, defaultDate, strTime)

    If IsDate(strDateStart) Then
        makeDatePeriod = FormatDate(strDateStart) & " " & Trim(strTime)
    Else

        If IsDate(defaultDate) Then
            makeDatePeriod = FormatDate(defaultDate) & " " & Trim(strTime)
        Else
            makeDatePeriod = FormatDate(Now()) & " " & Trim(strTime)
        End If
    End If

End Function


Function toStr(val)

    If IsNull(val) Then
        toStr = ""
    Else
        toStr = CStr(val)
    End If

End Function

Function toDbl(val)

    If Not IsNull(val) And IsNumeric(val) Then
        toDbl = CDbl(val)
    Else
        toDbl = 0
    End If

End Function

' ======================== By Rhoda
Function CheckVst(patID)
    Dim rst, sql, ot
    ot = False
    Set rst = CreateObject("ADODB.Recordset")
    sql = "Select * from visitation where patientid = '" & patID & "' "
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
            If .RecordCount > 0 Then
                ot = True
            End If
        .Close
    End With
    CheckVst = ot
    Set rst = Nothing
End Function

Function BillAccount(patID)
    Dim sql, rst, ot
    ot = False
    Set rst = CreateObject("ADODB.Recordset")
    With rst
        sql = "SELECT * FROM InsuredPatient WHERE InitialDependantID LIKE '" & patID & "%' "
        .open qryPro.FltQry(sql), conn, 3, 4
        If .RecordCount > 0 Then
            ot = True
        End If
        .Close
    End With
    BillAccount = ot
    Set rst = Nothing
End Function

' Sub DeleteRecord()
'     SetPageMessages "There is no visit and dependant"
' '    conn.execute qryPro.FltQry(("Delete FROM InsuredPatient where patientID = '" & pat & "'"))
' '    conn.execute qryPro.FltQry(("Delete FROM NextOfKin where patientID = '" & pat & "'"))
' '    conn.execute qryPro.FltQry(("Delete FROM Patient where patientID = '" & pat & "'"))
' End Sub

    addJS

 Sub addJS()
     Dim js

     js = ""
     js = js & "<script>"
     js = js & "if(document.querySelector('.btn-del')) {"
     js = js & "    document.querySelector('.btn-del').addEventListener('click', function(event) {"
     js = js & "        window.location.href = `wpgPrtPrintLayoutAll.asp?PrintLayoutName=PatientRCP&PositionForTableName=Patient&PatientID=${this.dataset.patid}&patientflag=true`;"
     js = js & "    })"
     js = js & "}"

     js = js & "</script>"

     response.write js
 End Sub

Function CheckNextofKin(patID)
        Dim sql, rst, ot
        ot = False
        Set rst = CreateObject("ADODB.Recordset")
        With rst
        sql = "SELECT * from nextofkin WHERE patientid  = '" & patID & "' "
        rst.open qryPro.FltQry(qry.pro.FltQry(sql)), conn, 3, 4
        If .RecordCount > 0 Then
          ot = True
        End If
        .Close
        End With
        CheckNextofKin = ot
        Set rst = Nothing
End Function

Function CheckDependant(patID)
    Dim sql, rst, ot
    ot = False
    Set rst = CreateObject("ADODB.Recordset")
    sql = "SELECT initialdependantid FROM Visitation WHERE patientid =  '" & patID & "' "
    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
            If .RecordCount > 0 Then
              ot = True
            End If
        .Close
    End With
    CheckDependant = ot
    Set rst = Nothing
End Function
' =======================

Sub StylesAdded()
    response.write "    <style>"
    response.write "      :root {"
    response.write "        --bc: white;"
    response.write "        --bp: #0994de;"
    response.write "        --br: #ffd54a;"
    response.write "        --brhv: #ffc400;"
    response.write "        --bphv: #087ab8;"
    response.write "        --bss: #05ab5d;"
    response.write "        --bsshv: #198754;"
    response.write "        --bwrn: #ff3f52;"
    response.write "        --bwrnhv: #dc3545;"
    response.write "        --bs: #939393;"
    response.write "        --bshv: #6c757d;"
    response.write "        --bsty-primary: #005f92;"
    response.write "        --bsty-alert: #dc3545;"
    response.write "        --bsty-alert-hover: #ff6776;"
    response.write "        --bsty-primary-hover: #0994de;"
    response.write "        --bsty-success: #198754;"
    response.write "        --bsty-success-hover: #05ab5d;"
    response.write "        --bsty-sec: #ffc400;"
    response.write "        --bsty-sec-hover: #ffd54a;"
    response.write "      }"
    response.write "      .holder {"
    response.write "        display: flex;"
    response.write "      }"
    response.write "      .btsty {"
    response.write "        width: fit-content;"
    response.write "        padding: 4px;"
    response.write "        margin: 0px 0px 0px 5px;"
    response.write "        border-radius: 4px;"
    response.write "        cursor: pointer;"
    response.write "        text-align: center;"
    response.write "        white-space: nowrap;"
    response.write "        border: none;"
    response.write "        font-size: 13.33px;"
    response.write "        text-decoration: none;"
    response.write "      }"
    response.write "      .pm {"
    response.write "        color: var(--bsty-primary);"
    response.write "      }"
    response.write "      .pm:hover {"
    response.write "        text-decoration: underline;"
    response.write "        color: var(--bsty-primary-hover);"
    response.write "      }"
    response.write "      .rd {"
    response.write "        color: var(--bsty-sec);"
    response.write "      }"
    response.write "      .rd:hover {"
    response.write "        text-decoration: underline;"
    response.write "        color: var(--bsty-sec-hover);"
    response.write "      }"
    response.write "      .bnm:hover {"
    response.write "        text-decoration: underline;"
    response.write "      }"
    response.write "      .wrn {"
    response.write "        color: var(--bsty-alert);"
    response.write "      }"
    response.write "      .wrn:hover {"
    response.write "        color: var(--bsty-alert-hover);"
    response.write "        text-decoration: underline;"
    response.write "      }"
    response.write "      .scc {"
    response.write "        color: var(--bsty-success);"
    response.write "      }"
    response.write "      .scc:hover {"
    response.write "        color: var(--bsty-success-hover);"
    response.write "        text-decoration: underline;"
    response.write "      }"
    response.write "      .bp {"
    response.write "        background-color: var(--bp);"
    response.write "        color: var(--bc);"
    response.write "        margin: 0px 5px 0px 5px;"
    response.write "        padding: 4px 12px;"
    response.write "      }"
    response.write "      .br {"
    response.write "        background-color: var(--br);"
    response.write "        color: var(--bc);"
    response.write "        margin: 0px 5px 0px 5px;"
    response.write "        padding: 4px 12px;"
    response.write "      }"
    response.write "      .obp {"
    response.write "        box-shadow: 0px 0px 1px 1px var(--bp);"
    response.write "        color: var(--bphv);"
    response.write "        margin: 0px 5px 0px 5px;"
    response.write "        padding: 4px 12px;"
    response.write "      }"
    response.write "      .obp:hover {"
    response.write "        background-color: var(--bp);"
    response.write "        color: var(--bc);"
    response.write "      }"
    response.write "      .bp:hover {"
    response.write "        background-color: var(--bphv);"
    response.write "      }"
    response.write "      .bss {"
    response.write "        background-color: var(--bss);"
    response.write "        color: var(--bc);"
    response.write "        margin: 0px 5px 0px 5px;"
    response.write "        padding: 4px 12px;"
    response.write "      }"
    response.write "      .obss {"
    response.write "        box-shadow: 0px 0px 1px 1px var(--bss);"
    response.write "        color: var(--bsshv);"
    response.write "        margin: 0px 5px 0px 5px;"
    response.write "        padding: 4px 12px;"
    response.write "      }"
    response.write "      .obss:hover {"
    response.write "        background-color: var(--bss);"
    response.write "        color: var(--bc);"
    response.write "      }"
    response.write "      .bss:hover {"
    response.write "        background-color: var(--bsshv);"
    response.write "      }"
    response.write "      .br:hover {"
    response.write "        background-color: var(--brhv);"
    response.write "      }"
    response.write "      .bwrn {"
    response.write "        background-color: var(--bwrn);"
    response.write "        color: var(--bc);"
    response.write "        margin: 0px 5px 0px 5px;"
    response.write "        padding: 4px 12px;"
    response.write "      }"
    response.write "      .obwrn {"
    response.write "        box-shadow: 0px 0px 1px 1px var(--bwrn);"
    response.write "        color: var(--bwrnhv);"
    response.write "        margin: 0px 5px 0px 5px;"
    response.write "        padding: 4px 12px;"
    response.write "      }"
    response.write "      .obwrn:hover {"
    response.write "        background-color: var(--bwrn);"
    response.write "        color: var(--bc);"
    response.write "      }"
    response.write "      .bwrn:hover {"
    response.write "        background-color: var(--bwrnhv);"
    response.write "      }"
    response.write "      .bs {"
    response.write "        background-color: var(--bs);"
    response.write "        color: var(--bc);"
    response.write "        margin: 0px 5px 0px 5px;"
    response.write "        padding: 4px 12px;"
    response.write "      }"
    response.write "      .obs {"
    response.write "        box-shadow: 0px 0px 1px 1px var(--bs);"
    response.write "        color: var(--bshv);"
    response.write "        margin: 0px 5px 0px 5px;"
    response.write "        padding: 4px 12px;"
    response.write "      }"
    response.write "      .obs:hover {"
    response.write "        background-color: var(--bshv);"
    response.write "        color: var(--bc);"
    response.write "      }"
    response.write "      .bs:hover {"
    response.write "        background-color: var(--bshv);"
    response.write "      }"
    response.write "      .bold {"
    response.write "        font-weight: 600;"
    response.write "      }"
    response.write "      .aln {"
    response.write "        padding: 0px !important;"
    response.write "        margin: 0px !important;"
    response.write "      }"
    response.write "    </style>"
    response.write "    <style>"
    response.write "      * {"
    response.write "        margin: 0;"
    response.write "        padding: 0;"
    response.write "      }"
    response.write "      body {"
    response.write "        background-color: #f9f9f9;"
    response.write "      }"
    response.write "      .table-holder::-webkit-scrollbar {"
    response.write "        width: 5px;"
    response.write "        height: 5px;"
    response.write "      }"
    response.write "      .table-holder::-webkit-scrollbar-track {"
    response.write "        background: #efefef;"
    response.write "      }"
    response.write "      .table-holder::-webkit-scrollbar-thumb {"
    response.write "        background: #b4b4b4;"
    response.write "      }"
    response.write "      .table-holder::-webkit-scrollbar-thumb:hover {"
    response.write "        background: #888;"
    response.write "      }"
    response.write "      .table-holder::-webkit-scrollbar-button:hover {"
    response.write "        background: #888;"
    response.write "      }"
    response.write "      .tab-tbl-hld::-webkit-scrollbar {"
    response.write "        width: 5px;"
    response.write "        height: 5px;"
    response.write "      }"
    response.write "      .tab-tbl-hld::-webkit-scrollbar-track {"
    response.write "        background: #efefef;"
    response.write "      }"
    response.write "      .tab-tbl-hld::-webkit-scrollbar-thumb {"
    response.write "        background: #b4b4b4;"
    response.write "      }"
    response.write "      .tab-tbl-hld::-webkit-scrollbar-thumb:hover {"
    response.write "        background: #888;"
    response.write "      }"
    response.write "      .tab-tbl-hld::-webkit-scrollbar-button:hover {"
    response.write "        background: #888;"
    response.write "      }"
    response.write "      .df {"
    response.write "        display: flex;"
    response.write "        align-items: center;"
    response.write "      }"
    response.write "      .tab-holder {"
    response.write "        margin: 10px 20px;"
    response.write "        background-color: white;"
    response.write "        border-radius: 5px;"
    response.write "        box-shadow: 0px 0px 5px #dddddd;"
    response.write "      }"
    response.write "      .tab-head {"
    ' response.write "        border-bottom: 3px solid #ffe49d;"
    response.write "        padding: 7px;"
    response.write "        justify-content: space-between;"
    response.write "        overflow: hidden;"
    response.write "      }"
    response.write "      .head-lb:hover {"
    response.write "        color: #0954de;"
    response.write "      }"
    response.write "      .head-lb {"
    response.write "        font-weight: 600;"
    response.write "        font-family: 'Segoe UI';"
    response.write "        padding-inline: 13px;"
    response.write "        font-size: 15px;"
    response.write "        min-width: 200px;"
    response.write "      }"
    response.write "      .head-right {"
    response.write "        padding-right: 13px;"
    response.write "      }"
    response.write "      .plr10 {"
    response.write "        padding-inline: 10px;"
    response.write "      }"
    response.write "      .icn {"
    response.write "        color: #006da8;"
    response.write "        font-size: 15px;"
    response.write "        transition: all 0.3s ease;"
    response.write "      }"
    response.write "      .cp {"
    response.write "        cursor: pointer;"
    response.write "      }"
    response.write "      .tab-table {"
    response.write "        padding: 10px 10px 0px 10px;"
    response.write "        overflow: hidden;"
    response.write "        max-height: 600px;"
    response.write "        transition: all 0.3s ease-in-out;"
    response.write "      }"
    response.write "      .tab-table:last-child .tbl-aln:last-child {"
    response.write "        border-bottom: none;"
    response.write "      }"
    response.write "      .table-holder {"
    response.write "        overflow: auto;"
    response.write "        max-height: 500px;"
    response.write "      }"
    response.write "      .tab-tbl-hld {"
    response.write "        overflow: auto;"
    response.write "        max-height: 1000px;"
    response.write "        transition: all 0.4s ease;"
    response.write "      }"
    response.write "      .max-zero {"
    response.write "        max-height: 0px;"
    response.write "        padding: 0;"
    response.write "        margin: 0;"
    response.write "        overflow: hidden;"
    response.write "      }"
    response.write "      .active-r {"
    response.write "        rotate: 180deg;"
    response.write "      }"
    response.write "      .table-holder {"
    response.write "        font-family: 'Segoe UI';"
    response.write "        margin: 0px 4px 4px 4px;"
    response.write "        padding: 5px 10px 20px 10px;"
    response.write "      }"
    response.write "      .tbl-aln {"
    response.write "        padding: 5px 10px 5px 10px;"
    response.write "      }"
    response.write "      .tbl-aln:last-child {"
    response.write "        padding: 0px 10px 20px 10px;"
    response.write "        border-bottom: 2px solid #ddd;"
    response.write "      }"
    response.write "      .tbl-aln-bttom {"
    response.write "        padding: 0px 10px 20px 10px;"
    response.write "      }"
    response.write "      .tbl {"
    response.write "        min-width: 100%;"
    response.write "        border-radius: 4px;"
    response.write "        padding: 5px;"
    response.write "        box-shadow: 0px 0px 6px 1px #dddddd;"
    response.write "        border-collapse: collapse;"
    response.write "        margin: auto;"
    response.write "      }"
    response.write "      .field-h {"
    response.write "        font-family: 'Segoe UI';"
    response.write "        position: sticky;"
    response.write "        z-index: 3;"
    response.write "        top: 0px;"
    response.write "        font-size: 13px;"
    response.write "        text-align: left;"
    response.write "        background-color: white;"
    response.write "      }"
    response.write "      .field-r {"
    response.write "        font-family: 'Open Sans', sans-serif;"
    response.write "      }"
    response.write "      .field-r:nth-of-type(2n) {"
    response.write "        background-color: #f9f9f9;"
    response.write "      }"
    response.write "      .field-r:hover {"
    response.write "        background-color: #e3f9ff;"
    response.write "      }"
    response.write "      .fh {"
    response.write "        padding: 6px;"
    response.write "        text-align: left;"
    response.write "        font-weight: 600;"
    response.write "        border-bottom: 1px solid;"
    response.write "      }"
    response.write "      .t-right {"
    response.write "        text-align: right;"
    response.write "      }"
    response.write "      .t-center {"
    response.write "        text-align: center;"
    response.write "      }"
    response.write "      .t-left {"
    response.write "        text-align: left;"
    response.write "      }"
    response.write "      .field-r td {"
    response.write "        font-size: 14px;"
    response.write "      }"
    response.write "      .field-b tr td {"
    response.write "        border-bottom: 1px solid #dddddd;"
    response.write "        padding: 10px 15px 10px 15px;"
    response.write "        font-size: 13px;"
    response.write "        min-height: 20px;"
    response.write "      }"
    response.write "      .field-b tr:last-child td {"
    response.write "        border-bottom: none;"
    response.write "      }"
    response.write "      .field-b tr td:Not(:last-child) {"
    response.write "        border-right: 1px solid #dddddd;"
    response.write "      }"
    response.write "      .table-head {"
    response.write "        font-family: 'Roboto', sans-serif;"
    response.write "        font-weight: bold;"
    response.write "        padding: 10px;"
    response.write "      }"
    response.write "      @media print {"
    response.write "        .pn {"
    response.write "          display: none;"
    response.write "        }"
    response.write "        .tbl {"
    response.write "          box-shadow: none;"
    response.write "          border: 1px solid;"
    response.write "        }"
    response.write "        .field-h tr .fh,"
    response.write "        .field-b tr td {"
    response.write "          color: black;"
    response.write "          border: 1px solid black !important;"
    response.write "          background-color: none;"
    response.write "        }"
    response.write "        .field-h {"
    response.write "          position: inherit;"
    response.write "        }"
    response.write "      }"
    response.write "      .tabs {"
    response.write "        margin: 10px;"
    response.write "        font-weight: 600;"
    response.write "        font-family: 'Segoe UI';"
    response.write "        width: fit-content;"
    response.write "        background-color: white;"
    response.write "      }"
    response.write "      .tab {"
    response.write "        padding: 7px 15px 5px 15px;"
    response.write "        cursor: pointer;"
    response.write "        border-bottom: 2px solid #d2d2d2;"
    response.write "      }"
    response.write "      .tab:hover {"
    response.write "        background-color: #f0f3fa;"
    response.write "      }"
    response.write "      .tab:first-child {"
    response.write "        border-top-left-radius: 4px;"
    response.write "      }"
    response.write "      .tab:last-child {"
    response.write "        border-top-right-radius: 4px;"
    response.write "      }"
    response.write "      .a-tab {"
    response.write "        background-color: #f0f3fa;"
    response.write "        color: #005f92;"
    response.write "        border-bottom: 2px solid #005f92;"
    response.write "      }"
    response.write "      .a-tab:hover {"
    response.write "        background-color: #f0f3fa;"
    response.write "      }"
    response.write "      .dn {"
    response.write "        display: none;"
    response.write "      }"
    response.write "      .tbl-dsc {"
    response.write "        font-weight: 600;"
    response.write "        align-items: center;"
    response.write "        justify-content: center;"
    response.write "      }"
    response.write "      .dsc {"
    response.write "        padding: 5px;"
    response.write "        font-weight: 600;"
    response.write "      }"
    response.write "      .hdr {"
    response.write "        font-weight: 600;"
    response.write "      }"
    response.write "      .tbl-top {"
    response.write "        width: 100%;"
    response.write "        padding: 5px 20px 0px 20px;"
    response.write "      }"
    response.write "      .fht {"
    response.write "        padding: 2px;"
    response.write "        text-decoration: underline;"
    response.write "      }"
    response.write "      .h-alnp {"
    response.write "        padding: 0px 10px;"
    response.write "      }"
    response.write "    </style>"
    response.write "    <style>"
    response.write "      .patient-profile {"
    response.write "        margin-top: 2px;"
    response.write "        display: flex;"
    response.write "        width: 100%;"
    response.write "        border-bottom: 1px solid var(--navi-bga);"
    response.write "      }"
    response.write "      .pt-details {"
    response.write "        display: flex;"
    response.write "        width: 75%;"
    response.write "        border: 1px solid #dddddd;"
    response.write "        border-radius: 4px;"
    response.write "        background-color: #dddddd51;"
    response.write "      }"
    response.write "      .details1 {"
    response.write "        overflow: hidden;"
    response.write "        width: 50%;"
    response.write "        padding-left: 8%;"
    response.write "        padding-top: 1%;"
    response.write "        padding-bottom: 1%;"
    response.write "      }"
    response.write "      .pt-img {"
    response.write "        width: 25%;"
    response.write "        display: flex;"
    response.write "        align-items: center;"
    response.write "        justify-content: center;"
    response.write "        padding-right: 2%;"
    response.write "      }"
    response.write "      .content {"
    response.write "        display: flex;"
    response.write "      }"
    response.write "      .lb1 {"
    response.write "        min-width: 130px;"
    response.write "        font-size: 13.5px;"
    response.write "        text-align: left;"
    response.write "        margin-bottom: 5px !important;"
    response.write "      }"
    response.write "      .lb2 {"
    response.write "        font-size: 13.5px;"
    response.write "        min-width: 130px;"
    response.write "        text-align: left;"
    response.write "        margin-bottom: 5px !important;"
    response.write "      }"
    response.write "      .lb2a {"
    response.write "        font-size: 13.5px;"
    response.write "        min-width: 130px;"
    response.write "        text-align: left;"
    response.write "        margin-bottom: 5px !important;"
    response.write "      }"
    response.write "      .lb2b {"
    response.write "        font-weight: bold;"
    response.write "        font-size: 13px;"
    response.write "        text-align: left;"
    response.write "        margin-bottom: 5px !important;"
    response.write "      }"
    response.write "    </style>"

End Sub

Sub ScpAdded()
    response.write " <script>"
    response.write "  const holders = document.querySelectorAll('.tab-holder');"
    response.write "  function addToggleEvent(targetElement) {"
    response.write "    const collapse = targetElement.querySelector('.rotate');"
    response.write "    const content = targetElement.querySelector('.tab-tbl-hld');"
    response.write "    const headlb = targetElement.querySelector('.head-lb');"
    response.write "    if (headlb) {"
    response.write "      headlb.addEventListener('click', (event) => {"
    response.write "        event.stopPropagation();"
    response.write "        collapse.classList.toggle('active-r');"
    response.write "        content.classList.toggle('max-zero');"
    response.write "      });"
    response.write "    }"
    response.write "  }"
    response.write "  function addToggleEvent1(targetElement) {"
    response.write "    const collapse = targetElement.querySelector('.rotate');"
    response.write "    const content = targetElement.querySelector('.tab-tbl-hld');"
    response.write "    if (collapse) {"
    response.write "      collapse.addEventListener('click', (event) => {"
    response.write "        event.stopPropagation();"
    response.write "        collapse.classList.toggle('active-r');"
    response.write "        content.classList.toggle('max-zero');"
    response.write "      });"
    response.write "    }"
    response.write "  }"
    response.write "  holders.forEach((holder) => {"
    response.write "    addToggleEvent(holder);"
    response.write "  });"
    response.write "  holders.forEach((holder) => {"
    response.write "    addToggleEvent1(holder);"
    response.write "  });"
    response.write "       function GetDataFromDb2() {"
    response.write "         var getStr = 'ProcedureName=ProcessUPdate&PatientID=" & GetRecordField("PatientID") & "';"
    response.write "         let xhr = new XMLHttpRequest();"
    response.write "         var url = 'wpgXmlHttp.asp?' + getStr;"
    ' response.write "         xhr.onload = function() {"
    ' response.write "           var responseData = xhr.responseText;"
    ' response.write "           var apLst = document.getElementById('aptLst');"
    ' response.write "           var responseData = xhr.responseText;"
    ' response.write "           apLst.innerHTML = responseData;"
    ' response.write "         };"
    response.write "         xhr.open('GET', url);"
    response.write "         xhr.send();"
    response.write "         location.replace('wpgPrtPrintLayoutAll.asp?PrintLayoutName=PatientRCP&PositionForTableName=Patient&PatientID=" & GetRecordField("PatientID") & "');"
    response.write "       }"
    response.write " </script>"


End Sub

Sub LoaderModal()
    response.write " <div class='load'>"
    response.write "    <div class='l-cnt'>"
    response.write "      <p class='l-txt'>Loading</p>"
    response.write "      <div class='l-circle'></div>"
    response.write "    </div>"
    response.write " </div>"
    response.write " <div id='modal' class='modal'> "
    response.write "    <div class='close-modal'> "
    response.write "        <i class='fa-solid fa-arrow-left back'></i>"
    response.write "        <i class='fa-solid fa-window-maximize max'></i>"
    response.write "        <i class='fa-solid fa-xmark close'></i>"
    response.write "    </div> "
    response.write "    <div id='modal-holder' class='modal-holder'> "
    response.write "        <div class='modal-content'> "
    response.write "            <div class='load-m'> "
    response.write "                <div class='l-cnt-m'> "
    response.write "                <p class='l-txt-m'>Loading</p> "
    response.write "                <div class='l-circle-m'></div> "
    response.write "                </div> "
    response.write "            </div> "
    response.write "            <div class='modal-content1'>&nbsp;</div> "
    response.write "        </div> "
    response.write "    </div> "
    response.write " </div> "
End Sub

Sub LoaderModalStys()
    response.write "  <style>"
    response.write " .load { "
    response.write "   position: fixed; "
    response.write "   padding: 1%; "
    response.write "   z-index: 50; "
    response.write "   width: 100%; "
    response.write "   height: 100%;"
    response.write "   display: flex; "
    response.write "   justify-content: center; "
    response.write "   align-items: center; "
    response.write "   background-color: #ffffffbf; "
    response.write "   transition: opacity 0.9s, visibility 0.9s, background 0.9s; "
    response.write " } "
    response.write " .l-cnt { "
    response.write "   width: 100%; "
    response.write "   height: 100%; "
    response.write "   display: flex; "
    response.write "   align-items: center; "
    response.write "   justify-content: center; "
    response.write " } "
    response.write " .l-circle { "
    response.write "   width: 40px; "
    response.write "   height: 40px; "
    response.write "   display: flex; "
    response.write "   align-items: center; "
    response.write "   justify-content: center; "
    response.write " } "
    response.write " .l-txt { "
    response.write "   font-size: 20px; "
    response.write "   margin: 5px; "
    response.write "   color: black; "
    response.write "   text-shadow: 0px 0px 1px white; "
    response.write " } "
    response.write " .l-circle::after { "
    response.write "   content: ''; "
    response.write "   width: 20px; "
    response.write "   height: 20px; "
    response.write "   border: 4px solid #dddddd; "
    response.write "   border-radius: 50%; "
    response.write "   border-top-color: #009580; "
    response.write "   animation: loading 0.9s ease infinite; "
    response.write " } "
    response.write " @keyframes loading { "
    response.write "   from { "
    response.write "     transform: rotate(0turn); "
    response.write "   } "
    response.write "   to { "
    response.write "     transform: rotate(1turn); "
    response.write "   } "
    response.write " } "
    response.write " .hide-load { "
    response.write "   opacity: 0; "
    response.write "   visibility: hidden; "
    response.write "   background: none; "
    response.write "   display: none; "
    response.write " } "
    response.write " .menup{"
    response.write "     position: absolute;"
    response.write "     z-index: 10;"
    response.write "     background-color: #f3f3f3;"
    response.write " }"
    response.write " "
    response.write " .modal { "
    response.write "     display: none;  "
    response.write "     position: fixed; "
    response.write "     z-index: 999; "
    response.write "     left: 0; "
    response.write "     top: 0; "
    response.write "     width: 100%; "
    response.write "     height: 100vh; "
    response.write "     background-color: rgba(0, 0, 0, 0.5); "
    response.write "     opacity: 0; "
    response.write "     transition: opacity 0.3s ease; "
    response.write " } "
    response.write " .modal.show { "
    response.write "     opacity: 1;  "
    response.write " } "
    response.write " .modal-holder { "
    response.write "     display: flex; "
    response.write "     justify-content: center; "
    response.write "     width: 100%; "
    response.write "     height: 100%; "
    response.write " } "
    response.write " .modal-content { "
    response.write "     background-color: #fefefe; "
    response.write "     margin: 15% auto; "
    response.write "     margin-top: 0px; "
    response.write "     padding: 10px; "
    response.write "     border: 1px solid #888; "
    response.write "     border-radius: 4px; "
    response.write "     width: 80%; "
    response.write "     height: 70%; "
    response.write " } "
    response.write " .modal-content1 { "
    response.write "     width: 100%; "
    response.write "     height: 100%; "
    response.write "     position: sticky; "
    response.write "     top: 0; "
    response.write "     z-index: 0; "
    response.write " } "
    response.write " .modalFrame { "
    response.write "     border: 0; "
    response.write "     width: 100%; "
    response.write "     height: 100%; "
    response.write " } "
    response.write " .close-modal { "
    response.write "     display: flex; "
    response.write "     justify-content: center; "
    response.write "     height: 10%; "
    response.write "     align-items: center; "
    response.write " } "
    response.write " .max, .close, .back { "
    response.write "     color: #ffffff; "
    response.write "     font-size: 12px; "
    response.write "     width: 25px; "
    response.write "     height: 25px; "
    response.write "     margin: 5px; "
    response.write "     border-radius: 50%; "
    response.write "     background-color: #dddddd66; "
    response.write "     font-weight: bold; "
    response.write "     cursor: pointer; "
    response.write "     display: flex !important; "
    response.write "     align-items: center; "
    response.write "     justify-content: center; "
    response.write "     transition: all 0.4s; "
    response.write " } "
    response.write " .back:hover, "
    response.write " .back:focus, "
    response.write " .max:hover, "
    response.write " .max:focus, "
    response.write " .close:hover, "
    response.write " .close:focus { "
    response.write "     color: black; "
    response.write "     text-decoration: none; "
    response.write "     cursor: pointer; "
    response.write "     background-color: #dddddd; "
    response.write " } "
    response.write " "
    response.write " .maximize { "
    response.write "     z-index: 5; "
    response.write "     position: fixed; "
    response.write "     top: 0; "
    response.write " } "
    response.write " .max-content { "
    response.write "     margin: 0; "
    response.write "     width: 100%; "
    response.write "     height: 100%; "
    response.write "     padding: 8px; "
    response.write " } "
    response.write " .max-close { "
    response.write "     height: 40px; "
    response.write "     position: sticky; "
    response.write "     top: 0; "
    response.write "     z-index: 6; "
    response.write " } "
    response.write " body.modal-open { "
    response.write "     overflow: hidden; "
    response.write " } "
    response.write " .load-m { "
    response.write "     position: sticky; "
    response.write "     z-index: 50; "
    response.write "     top: 0; "
    response.write "     left: 0; "
    response.write "     width: 100%; "
    response.write "     height: 100%; "
    response.write "     display: flex; "
    response.write "     justify-content: center; "
    response.write "     align-items: center; "
    response.write "     background-color: rgb(0 0 0 / 24%); "
    response.write "     transition: opacity 0.5s, visibility 0.5s, background 0.5s; "
    response.write " } "
    response.write " .l-cnt-m { "
    response.write "     width: 100%; "
    response.write "     display: flex; "
    response.write "     align-items: center; "
    response.write "     justify-content: center; "
    response.write " } "
    response.write " .l-circle-m { "
    response.write "     width: 40px; "
    response.write "     height: 40px; "
    response.write "     display: flex; "
    response.write "     align-items: center; "
    response.write "     justify-content: center; "
    response.write " } "
    response.write " .l-txt-m { "
    response.write "     font-size: 20px; "
    response.write "     margin: 5px; "
    response.write " } "
    response.write " .l-circle-m::after { "
    response.write "     content: ''; "
    response.write "     width: 20px; "
    response.write "     height: 20px; "
    response.write "     border: 4px solid #dddddd; "
    response.write "     border-radius: 50%; "
    response.write "     border-top-color: #009580; "
    response.write "     animation: loading 0.9s ease infinite; "
    response.write " } "
    response.write " @keyframes loading { "
    response.write "     from { "
    response.write "     transform: rotate(0turn); "
    response.write "     } "
    response.write "     to { "
    response.write "     transform: rotate(1turn); "
    response.write "     } "
    response.write " } "
    response.write " .hide-load { "
    response.write "     position: sticky; "
    response.write "     z-index: 50; "
    response.write "     top: 0; "
    response.write "     display: none; "
    response.write " } "
    response.write " .removePad { "
    response.write "     padding: 0px; "
    response.write " } "
    response.write "  </style>"

End Sub

Sub LoaderModalScp()
    response.write " <script>"

    response.write "  const parentWindow = parent || window; "
    response.write "  const modal = parentWindow.document.getElementById('modal'); "
    response.write "  const iframem = parentWindow.document.createElement('iframe');"
    response.write "  const modalContent = modal.querySelector('.modal-content1'); "
    response.write "  const modalContent1 = modal.querySelector('.modal-content'); "
    response.write "  const loadBm = parentWindow.document.querySelector('.load-m'); "
    response.write "  const closeBtn = parentWindow.document.querySelector('.close'); "
    response.write "  const mdBack = parentWindow.document.querySelector('.back'); "
    response.write "  const maxim = parentWindow.document.querySelector('.max'); "
    response.write "  const closeH = parentWindow.document.querySelector('.close-modal'); "
    response.write "  const holder = parentWindow.document.querySelector('.modal-holder'); "
    response.write "  const loadB = parentWindow.document.querySelector('.load'); "

    response.write "  modalContent1.classList.add('removePad'); "
    response.write "  modalContent.style.display = 'none'; "

    response.write " window.addEventListener('load', () => { "
    response.write "   loadB.style.display = 'none'; "
    response.write " }); "

    response.write "  function openModal(url) { "
    response.write "  event.stopPropagation(); "
    response.write "  iframem.src = url; "
    response.write "  modalContent.innerHTML = ''; "
    response.write "  modalContent.appendChild(iframem); "
    response.write "  iframem.classList.add('modalFrame'); "
    response.write "  modal.style.display = 'block'; "
    response.write "  modal.classList.add('show'); "
    response.write "  } "

    response.write "  iframem.addEventListener('load', () => { "
    response.write "  loadBm.classList.add('hide-load'); "
    response.write "  modalContent.style.display = 'block'; "
    response.write "  modalContent1.classList.remove('removePad'); "
    response.write "  }); "

    response.write "  closeBtn.addEventListener('click', function () { "
    response.write "  modal.style.display = 'none'; "
    response.write "  modal.classList.remove('show'); "
    response.write "  iframem.parentNode.removeChild(iframem); "
    response.write "  loadBm.classList.remove('hide-load'); "
    response.write "  location.reload(); "
    response.write "  modalContent.style.display = 'none'; "
    response.write "  modalContent1.classList.add('removePad'); "
    response.write "  setTimeout(() => { "
    response.write "      modal.style.display = 'none'; "
    response.write "      modalContent.innerHTML = ''; "
    response.write "  }, 300); "
    response.write "  }); "
    
    response.write "  mdBack.addEventListener('click', function () { "
    response.write "  iframem.contentWindow.history.back(); "
    response.write "  }); "
    
    response.write "  maxim.addEventListener('click', function () { "
    response.write "    holder.classList.toggle('maximize'); "
    response.write "    modalContent1.classList.toggle('max-content'); "
    response.write "    closeH.classList.toggle('max-close'); "
    response.write "  }); "

    response.write " window.addEventListener('load', () => { "
    response.write "   loadB.style.display = 'none'; "
    response.write " }); "
    response.write " </script>"

End Sub



Sub stylesButton()
    Dim css

    css = ""
    css = css & "<style>"
    css = css & "    .btn-del {"
    css = css & "        background-color: #f03e3e;"
    css = css & "        font-size: 13.33px;"
    css = css & "        font-weight: 600;"
    css = css & "        border-radius: 4px;"
    css = css & "        padding: 4px 12px;"
    css = css & "        color: white;"
    css = css & "        cursor: pointer;"
    css = css & "    }"
    css = css & "</style>"

    response.write css
End Sub
'<<--END_CODE_SEGMENT_PRINTHEADER-->>
'>
'>
'>
'>
'>
'<<--BEGIN_CODE_SEGMENT_PRINTFOOTER-->>

'<<--END_CODE_SEGMENT_PRINTFOOTER-->>
