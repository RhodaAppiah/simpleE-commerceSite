'<<--BEGIN_CODE_SEGMENT_PRINTHEADER-->>

addCSS
generateReport



Sub generateReport()

    Dim rst, sql, arPeriod, periodStart, periodEnd

    arPeriod = getDatePeriodFromDelim(Trim(Request.querystring("PrintFilter")))
    periodStart = Request.querystring("PrintFilter")
    periodEnd = Request.querystring("PrintFilter1")
    Set rst = CreateObject("ADODB.Recordset")

    sql = "WITH myTable AS ( "
    sql = sql & " SELECT DrugSaleItems.DrugID, Drug.DrugName, SUM(DrugSaleItems.Qty) AS topDrugs "
    sql = sql & " , DrugStockLevel.AvailableQty AS AvailableQty "
    sql = sql & " FROM DrugSaleItems "
    sql = sql & " INNER JOIN Drug ON Drug.DrugID = DrugSaleItems.DrugID "
    sql = sql & " INNER JOIN DrugStockLevel ON Drug.DrugID = DrugStockLevel.DrugID "
    sql = sql & " WHERE WorkingMonthID = 'MTH202404'  "
    sql = sql & " GROUP BY DrugSaleItems.DrugID, Drug.DrugName, DrugStockLevel.AvailableQty "
    sql = sql & " UNION ALL  "
    sql = sql & " SELECT DrugSaleItems2.DrugID, Drug.DrugName, SUM(DrugSaleItems2.DispenseAmt2) AS topDrugs "
    sql = sql & " , DrugStockLevel.AvailableQty AS AvailableQty "
    sql = sql & " FROM DrugSaleItems2 "
    sql = sql & " INNER JOIN Drug ON Drug.DrugID = DrugSaleItems2.DrugID "
    sql = sql & " INNER JOIN DrugStockLevel ON Drug.DrugID = DrugStockLevel.DrugID "
    sql = sql & " WHERE WorkingMonthID = 'MTH202404'  "
    sql = sql & " GROUP BY DrugSaleItems2.DrugID, Drug.DrugName, DrugStockLevel.AvailableQty "
    sql = sql & " ) " 
    sql = sql & " SELECT TOP 50 DrugID, DrugName, TopDrugs, AvailableQty "
    sql = sql & " FROM myTable "
    sql = sql & " GROUP BY  DrugID, DrugName, TopDrugs, AvailableQty "
    sql = sql & " ORDER BY topDrugs DESC ; "

    With rst
        .open qryPro.FltQry(sql), conn, 3, 4
        response.write "<table class='anaesthesia'> "
        response.write "    <thead> "
        response.write "        <tr class='anaesthesia'> "
        response.write "            <td colspan='5'> "
        response.write "                <b>STOCK LEVEL FOR TOP DRUGS SOLD BY QUANTITY</b> "
        response.write "            </td></tr> "
        response.write "        <tr class='h_names'> "
        response.write "            <th class=""name-align"">Drug</th> "
        response.write "            <th class=""name-align"">DrugID</th> "
        response.write "            <th class=""number-align"">Total Sold</th> "
        response.write "            <th class=""number-align"">Available Qty</th> "
        response.write "        </tr> "
        response.write "    </thead><tbody>"

        If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
                response.write "     <tr class = 'queryData'> "
                response.write "         <td class=""name-align"">" & .fields("DrugName") & "</td> "
                response.write "         <td class=""number-align"">" & .fields("DrugID") & "</td> "
                response.write "         <td class=""number-align"">" & .fields("TopDrugs") & "</td> "
                response.write "         <td class=""number-align"">" & .fields("AvailableQty") & "</td> "
                response.write "     </tr>"
                response.flush
                .MoveNext
            Loop
            response.write "    </tbody></table><br><br>" 
            generateReport1
        End If
        .Close
    End With
    Set rst = Nothing

End Sub

    Sub generateReport1()

        Dim rst, sql, arPeriod, periodStart, periodEnd
    
        arPeriod = getDatePeriodFromDelim(Trim(Request.querystring("PrintFilter")))
        periodStart = Request.querystring("PrintFilter")
        periodEnd = Request.querystring("PrintFilter1")
        Set rst = CreateObject("ADODB.Recordset")
    
        sql = "WITH myTable AS ( "
        sql = sql & " SELECT DrugSaleItems.DrugID, Drug.DrugName, SUM(DrugSaleItems.FinalAmt) AS topDrugs "
        sql = sql & " , DrugStockLevel.AvailableQty AS AvailableQty "
        sql = sql & " FROM DrugSaleItems "
        sql = sql & " INNER JOIN Drug ON Drug.DrugID = DrugSaleItems.DrugID "
        sql = sql & " INNER JOIN DrugStockLevel ON Drug.DrugID = DrugStockLevel.DrugID "
        sql = sql & " WHERE WorkingMonthID = 'MTH202404'  "
        sql = sql & " GROUP BY DrugSaleItems.DrugID, Drug.DrugName, DrugStockLevel.AvailableQty "
        sql = sql & " UNION ALL  "
        sql = sql & " SELECT DrugSaleItems2.DrugID, Drug.DrugName, SUM(DrugSaleItems2.FinalAmt) AS topDrugs "
        sql = sql & " , DrugStockLevel.AvailableQty AS AvailableQty "
        sql = sql & " FROM DrugSaleItems2 "
        sql = sql & " INNER JOIN Drug ON Drug.DrugID = DrugSaleItems2.DrugID "
        sql = sql & " INNER JOIN DrugStockLevel ON Drug.DrugID = DrugStockLevel.DrugID "
        sql = sql & " WHERE WorkingMonthID = 'MTH202404'  "
        sql = sql & " GROUP BY DrugSaleItems2.DrugID, Drug.DrugName, DrugStockLevel.AvailableQty "
        sql = sql & " ) " 
        sql = sql & " SELECT TOP 50 DrugID, DrugName, TopDrugs, AvailableQty "
        sql = sql & " FROM myTable "
        sql = sql & " GROUP BY  DrugID, DrugName, TopDrugs, AvailableQty "
        sql = sql & " ORDER BY topDrugs DESC ; "
    
        With rst
            .open qryPro.FltQry(sql), conn, 3, 4
            response.write "<table class='anaesthesia'> "
            response.write "    <thead> "
            response.write "        <tr class='anaesthesia'> "
            response.write "            <td colspan='5'> "
            response.write "                <b>STOCK LEVEL FOR TOP DRUGS SOLD BY SALE</b> "
            response.write "            </td></tr> "
            response.write "        <tr class='h_names'> "
            response.write "            <th class=""name-align"">Drug</th> "
            response.write "            <th class=""name-align"">DrugID</th> "
            response.write "            <th class=""number-align"">Total Sold</th> "
            response.write "            <th class=""number-align"">Available Qty</th> "
            response.write "        </tr> "
            response.write "    </thead><tbody>"
    
            If .RecordCount > 0 Then
                .MoveFirst
                Do While Not .EOF
                    response.write "     <tr class = 'queryData'> "
                    response.write "         <td class=""name-align"">" & .fields("DrugName") & "</td> "
                    response.write "         <td class=""number-align"">" & .fields("DrugID") & "</td> "
                    response.write "         <td class=""number-align"">" & .fields("TopDrugs") & "</td> "
                    response.write "         <td class=""number-align"">" & .fields("AvailableQty") & "</td> "
                    response.write "     </tr>"
                    response.flush
                    .MoveNext
                Loop
                response.write "    </tbody></table><br><br>"
            End If
            .Close
        End With
        Set rst = Nothing
    
    End Sub

Function getDatePeriodFromDelim(strDelimPeriod)
        
    Dim arPeriod, periodStart, periodEnd

    Dim arOut(1)

    arPeriod = Split(strDelimPeriod, "||")

    If UBound(arPeriod) >= 0 Then
        periodStart = arPeriod(0)
    End If
    If UBound(arPeriod) >= 1 Then
        periodEnd = arPeriod(1)
    End If

    periodStart = makeDatePeriod(Trim(periodStart), periodEnd, "0:00:00")
    periodEnd = makeDatePeriod(Trim(periodEnd), periodStart, "23:59:59")

    arOut(0) = periodStart
    arOut(1) = periodEnd

    getDatePeriodFromDelim = arOut

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

Sub addCSS()
  With response
    .write " <style> "
    .write "    .anaesthesia, .anaesthesia th, .anaesthesia td{ "
    .write "        border: 1px solid silver; "
    .write "        border-collapse: collapse; "
    .write "        padding: 5px; "
    .write "    } "
    .write "    .name-align{ "
    .write "        text-align:left; "
    .write "    } "
    .write "    .number-align{ "
    .write "        text-align:right; "
    .write "    } "
    .write "    .anaesthesia{ "
    .write "        width: 65vw; "
    .write "        margin: 0 auto; "
    .write "        font-family: sans-serif; "
    .write "        font-size: 15px; "
    .write "        box-sizing: border-box; "
    .write "    }"
    .write "    .anaesthesia tr{page-break-inside:avoid; "
    .write "        page-break-after:auto "
    .write "    } "
    .write "    .anaesthesia th, .anaesthesia td { "
    .write "        border: 1px solid silver; "
    ' .write "        text-align: left; "
    .write "        padding: 5px; "
    .write "        font-size:13px; "
    .write "        margin: 0 auto; "
    .write "    } "
    .write "    .queryData td{ "
    .write "        font-size: 12; "
    .write "    }  "
    .write "    .queryDataFoot td{ "
    .write "        font-size: 12; "
    .write "        background-color: blanchedalmond; "
    .write "    }  "
    .write "    .anaesthesia th{ "
    .write "        background-color: blanchedalmond; "
    ' .write "        text-align: center; "
    .write "        font-weight: bold;"
    .write "        font-size: 16px;"
    .write "        color:#000;"
    .write "   } "
    .write " </style> "
  End With
End Sub
'<<--END_CODE_SEGMENT_PRINTHEADER-->>
'>
'>
'>
'>
'>
'<<--BEGIN_CODE_SEGMENT_PRINTFOOTER-->>

'<<--END_CODE_SEGMENT_PRINTFOOTER-->>
