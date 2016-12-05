<?php
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
* ("License"); You may not use this file except in compliance with the License
* The Original Code is:  vtiger CRM Open Source
* The Initial Developer of the Original Code is vtiger.
* Portions created by vtiger are Copyright (C) vtiger.
* All Rights Reserved.
********************************************************************************/

require_once('Smarty_setup.php');

global $mod_strings, $app_strings, $app_list_strings, $adb, $theme;
$theme_path="themes/".$theme."/";
$image_path=$theme_path."images/";

$smarty = new vtigerCRM_Smarty;

$sql="select * from vtiger_organizationdetails";
$result = $adb->pquery($sql, array());
$organization_name = $adb->query_result($result,0,'organizationname');
$organization_address= $adb->query_result($result,0,'address');
$organization_city = $adb->query_result($result,0,'city');
$organization_state = $adb->query_result($result,0,'state');
$organization_code = $adb->query_result($result,0,'code');
$organization_country = $adb->query_result($result,0,'country');
$organization_phone = $adb->query_result($result,0,'phone');
$organization_fax = $adb->query_result($result,0,'fax');
$organization_website = $adb->query_result($result,0,'website');
//Handle for allowed organation logo/logoname likes UTF-8 Character
$organization_logo = decode_html($adb->query_result($result,0,'logo'));
$organization_logoname = decode_html($adb->query_result($result,0,'logoname'));
$front_logoname = $adb->query_result($result,0,'frontlogo');
$favicon_logoname = $adb->query_result($result,0,'faviconlogo');

if (isset($organization_name))
	$smarty->assign("ORGANIZATIONNAME",$organization_name);
if (isset($organization_address))
	$smarty->assign("ORGANIZATIONADDRESS",$organization_address);
if (isset($organization_city))
	$smarty->assign("ORGANIZATIONCITY",$organization_city);
if (isset($organization_state))
	$smarty->assign("ORGANIZATIONSTATE",$organization_state);
if (isset($organization_code))
	$smarty->assign("ORGANIZATIONCODE",$organization_code);
if (isset($organization_country))
    $smarty->assign("ORGANIZATIONCOUNTRY",$organization_country);
if (isset($organization_phone))
	$smarty->assign("ORGANIZATIONPHONE",$organization_phone);
if (isset($organization_fax))
	$smarty->assign("ORGANIZATIONFAX",$organization_fax);
if (isset($organization_website))
	$smarty->assign("ORGANIZATIONWEBSITE",$organization_website);
if (isset($organization_logo))
	$smarty->assign("ORGANIZATIONLOGO",$organization_logo);

$path = "test/logo";
$dir_handle = @opendir($path);

while ($file = readdir($dir_handle))
{
     $filetyp =str_replace(".",'',strtolower(substr($file, -4)));
   if($organization_logoname==$file || $front_logoname==$file || $favicon_logoname==$file )
   {    
        if ($filetyp == 'jpeg' OR $filetyp == 'jpg' OR $filetyp == 'png')
        {
		if($file!="." && $file!="..")
		{
		     $organization_logopath= $path;
		     if($organization_logoname==$file){
                         $organization_logopath= $path;
                         $logo_name=$file;
                     }
                     if($front_logoname==$file){
                         $front_logopath= $path;
                         $font_logo_name=$file;
                     }
                     if($favicon_logoname==$file){
                         $favicon_logopath= $path;
                         $favicon_logo_name=$file;
                     }
		}
        }
   }
}

if (isset($organization_logopath))
	$smarty->assign("ORGANIZATIONLOGOPATH",$path);
if (isset($organization_logopath))
	$smarty->assign("FRONTLOGOPATH",$front_logopath);
if (isset($organization_logopath))
$smarty->assign("FAVICONLOGOPATH",$favicon_logopath);
if (isset($organization_logoname))
	$smarty->assign("ORGANIZATIONLOGONAME",$logo_name);
if (isset($organization_logoname))
	$smarty->assign("FRONTLOGONAME",$font_logo_name);
if (isset($organization_logoname))
$smarty->assign("FAVICONLOGONAME",$favicon_logoname);
closedir($dir_handle);

$smarty->assign("MOD", return_module_language($current_language,'Settings'));
$smarty->assign("THEME", $theme);
$smarty->assign("IMAGE_PATH",$image_path);
$smarty->assign("APP", $app_strings);
$smarty->assign("CMOD", $mod_strings);
$smarty->display('Settings/CompanyInfo.tpl');
?>
