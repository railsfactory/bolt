/**
 * @author
 */
$(function(){
		
	$("#browser").treeview({collapsed: true });

function foldername_valid(foldername)
{
	var regex = new RegExp("^[a-z]+$", "gi");
	if(regex.test(foldername))
	{
		return true;
	}
	return false;
}
function loadFolders(folderid,folderpath,foldertype)
{
	$('#folderframe').attr('src','/media/'+folderid);	
	$('#folderpath').val(folderpath);
	$('#folderparent').val(folderid);
	if(foldertype=='childfolder')
	{
		$('#foldername').hide().fadeOut('slow');
		$('#createfolder').hide().fadeOut('slow');	
		$('#deletefolder').show().fadeIn('slow');		
		
	}
	else
	{
		$('#foldername').hide().fadeIn('slow');
		$('#createfolder').hide().fadeIn('slow');
		$('#deletefolder').hide().fadeOut('slow');
		
	}
}
function createfolder()
{		
	var foldername=$('#foldername').val();
	var infolder=$('#folderpath').val();
	var parentfolder=$('#folderparent').val();
	if(foldername=='')
	{
		alert('Please enter folder name');
		$('#foldername').focus();
	}
	else if(!foldername_valid(foldername))
	{
		alert('Please enter a valid folder name');
		$('#foldername').focus();
	} 
	else
	{
		$.ajax({
	   	type: 'POST',
	    url: '/media/create_folder',
	    data: 'folder='+foldername+'&infolder='+infolder+'&parentfolder='+parentfolder,
	    success: function(data){
			window.location.reload(true);
			}		
		});
	}	
}
});