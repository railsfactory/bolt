function edit_rec(go_to_url)
{
if($(".selall:checkbox:checked").length<1)
{
alert("please select atleast one record")
}
else if($(".selall:checkbox:checked").length>1)
{
alert("please select only one record")
return false;
}
else
{
	window.location.href=go_to_url+$(".selall:checkbox:checked").val()+""
}
}

function delete_rec(go_to_url)
{
 if($(".selall:checkbox:checked").length<1)
{
alert("please select atleast one record")
}
else if(confirm("Are you sure want to delete the record?"))
{
       vals=[]
       j=0
       var s=$(".selall:checkbox:checked")
	for(i=0;i<s.length;i++)
	{		
		vals[j]=s[i].value;
		j++;
	}
	window.location.href=go_to_url+vals

}
return false;
}

function select_all()
{

if($(".selall:checkbox:checked").length<1 && $('#chkunchk').attr("checked")==true)
{	
	$('.selall').attr("checked", "checked");
}
else
{

$('.selall').attr("checked", false);
}
}
function test()
{
totel=$(".selall:checkbox").length;
tochk=$(".selall:checkbox:checked").length
if(totel!=tochk)
{
	$('#chkunchk').attr("checked", false);
}
else
{
		$('#chkunchk').attr("checked", true);
}
}