$event:=Trigger event:C369

If ($event=On Saving New Record Event:K3:1) | ($event=On Saving Existing Record Event:K3:2)
	
	$obdata1:=[main:1]obdata1:2
	
	$meta:=New object:C1471("values"; New collection:C1472)
	
	$obdata1.meta:=$meta
	
	$sheets:=$obdata1.spreadJS.sheets
	
	For each ($sheet; $sheets)
		$dataTable:=$sheets[$sheet].data.dataTable
		For each ($c; $dataTable)
			$col:=$dataTable[$c]
			For each ($r; $col)
				$row:=$col[$r]
				$value:=New object:C1471("value"; $row.value; "row"; Num:C11($r); "col"; Num:C11($c); "sheet"; $sheet; "path"; New collection:C1472("spreadJS"; "sheets"; $sheet; "data"; "dataTable"; $c; $r).join("."))
				$meta.values.push($value)
			End for each 
		End for each 
	End for each 
	
End if 