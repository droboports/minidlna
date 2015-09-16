<?php 
$app = "minidlna";
$appname = "MiniDLNA";
$appversion = "1.1.5";
$appsite = "http://sourceforge.net/projects/minidlna/";
$apphelp = "http://sourceforge.net/p/minidlna/discussion/879957/";

$applogs = array("/tmp/DroboApps/".$app."/log.txt",
                 "/tmp/DroboApps/".$app."/minidlna.log");
$appconf = "/mnt/DroboFS/Shares/DroboApps/".$app."/etc/".$app.".conf";
$appautoconf = "/mnt/DroboFS/Shares/DroboApps/".$app."/etc/".$app.".auto";

$appprotos = array("http");
$appports = array("8200");
$droboip = $_SERVER['SERVER_ADDR'];
$apppage = $appprotos[0]."://".$droboip.":".$appports[0]."/";
if ($publicip != "") {
  $publicurl = $appprotos[0]."://".$publicip.":".$appports[0]."/";
} else {
  $publicurl = $appprotos[0]."://public.ip.address.here:".$appports[0]."/";
}
$portscansite = "http://mxtoolbox.com/SuperTool.aspx?action=scan%3a".$publicip."&run=toolpage";
?>
