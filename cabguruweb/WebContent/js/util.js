
function enableFromBox(){
	$("#locationFieldFrom").hide();
	$("#fromOption").show();
	$("#locationFieldFromText").attr('name', 'fromtemp');
	$("#fromOptionSelect").attr('name', 'from');
}

function disableFromBox(){

	$("#fromOption").hide();
	$("#locationFieldFrom").show();
	$("#locationFieldFromText").attr('name', 'from');
	$("#fromOptionSelect").attr('name', 'fromtemp');
}


function enableToBox(){
	$("#locationFieldTo").hide();
	$("#toOption").show();
	$("#locationFieldToText").attr('name', 'totemp');
	$("#toOptionSelect").attr('name', 'to');

}

function disableToBox(){

	$("#toOption").hide();
	$("#locationFieldTo").show();
	$("#locationFieldToText").attr('name', 'to');
	$("#toOptionSelect").attr('name', 'totemp');

}

function showCompanyDrivers(){
	$("#companydrivers").show();
	$("#noncompanydrivers").hide();
	$('#driverElemId').val($("#companydrivers").val());
}

function showNonCompanyDrivers(){
	$("#noncompanydrivers").show();
	$("#companydrivers").hide();
	$('#driverElemId').val($("#noncompanydrivers").val());
}

function restoreDriver(){
	if ($("#companydrivers").is(":visible")){
		$('#driverElemId').val($("#companydrivers").val());
		
	}else{
		$('#driverElemId').val($("#noncompanydrivers").val());
	}
}

function confirmDriverDelete(driverId){
	$("#driverListForm"+driverId).attr("action", "/cabguruweb/searchDriverResult.jsp");
	if(confirm('Are you sure you want to delete driver('+driverId+')?'))
		{

		$('#driverListForm'+driverId).append('<input type="hidden" name="drvrId" value='+driverId+' />');
		document.forms["driverListForm"+driverId].submit();
		}
	else{
		
	}
}

/* candidate for generalization and DRY */
function confirmCustomerDelete(userId){
	$("#customerListForm"+userId).attr("action", "/cabguruweb/searchCustResult.jsp");
	if(confirm('Are you sure you want to delete customer('+userId+')?'))
		{

		$('#customerListForm'+userId).append('<input type="hidden" name="usrId" value='+userId+' />');
		document.forms["customerListForm"+userId].submit();
		}
	else{
		
	}
}

