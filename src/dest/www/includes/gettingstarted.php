<p><?php echo $appname; ?> is a self-configuring app. It will retrieve a list of all the shares in the Drobo, and start indexing them automatically unless a manual configuration is provided.</p>
<?php if (file_exists($appconf)) { ?>
  <p><?php echo $appname; ?> is currently manually configured. This is the content of <code><?php echo $appconf; ?></code>:</p>
  <pre class="pre-scrollable">
<?php echo file_get_contents($appconf); ?>
  </pre>
<?php } elseif (file_exists($appautoconf)) { ?>
  <p><?php echo $appname; ?> is currently automatically configured. This is the content of <code><?php echo $appautoconf; ?></code>:</p>
  <pre class="pre-scrollable">
<?php echo file_get_contents($appautoconf); ?>
  </pre>
  <p>The &quot;Rescan&quot; button will force an update of the share list.</p>
  <a role="button" class="btn btn-default" href="?op=reload" onclick="$('#pleaseWaitDialog').modal(); return true"><span class="glyphicon glyphicon-refresh"></span> Rescan</a>
<?php } else { ?>
  <p><?php echo $appname; ?> is currently not configured. Please click the &quot;Rescan&quot; button to generate an automatic configuration.</p>
  <a role="button" class="btn btn-default" href="?op=reload" onclick="$('#pleaseWaitDialog').modal(); return true"><span class="glyphicon glyphicon-refresh"></span> Rescan</a>
<?php } ?>
