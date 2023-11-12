<?php
session_start();
$titulok = 'Prihlásenie / odhlásenie';

include('funkcie.php');
include('hlavicka.php');
include('navigacia.php');
include('akcia.php');
?>
<section>
<?php
echo "<h1>$titulok</h1>";

if (isset($_POST["prihlasmeno"]) && isset($_POST["heslo"]) && $pouzivatel = over_pouzivatela($mysqli, $_POST["prihlasmeno"], $_POST["heslo"])) {
	$_SESSION['uid'] = $pouzivatel['uid'];
	$_SESSION['user'] = $pouzivatel['username'];
	$_SESSION['meno'] = $pouzivatel['meno'];
	$_SESSION['priezvisko'] = $pouzivatel['priezvisko'];
	$_SESSION['admin'] = $pouzivatel['admin'];
} elseif (isset($_POST['odhlas'])) { // bol odoslany formular s odhlasenim
	session_unset();
	session_destroy();
}

if (isset($_POST['schval_zamietni']))
{
	if (!isset($_POST['akcia']))
	{
		echo '<p class="chyba">Vyberte akciu.</p>';
	} else {
		modify_comment_state($mysqli, $_POST['ids'], $_POST['akcia']);
	}
}

if (isset($_SESSION['user'])) {
?>
<p>Vitajte v systéme <strong><?php echo $_SESSION['meno'] . ' ' . $_SESSION['priezvisko']; ?></strong>.</p>
<?php
  if ($_SESSION['admin']) {
		echo '<p>Máš práva administrátora.</p>';
	}	else {
		echo '<p>NEmáš práva administrátora.</p>';
	}
?>
<form method="post"> 
  <p> 
    <input name="odhlas" type="submit" id="odhlas" value="Odhlás ma"> 
  </p> 
</form> 
<?php
	if ($_SESSION['admin']) {
		?> 
		<h1>Moderacia</h1>
		<form method="post">
			<table>
				<tbody>
				<tr>
					<th>schváľ / zamietni</th>
					<th>čokoláda</th>
					<th>komentár</th>
					<th>user</th>
					<th>čas</th>
				</tr>
				<?php

				foreach (get_all_comments($mysqli) as $comment) {
					echo '<tr>';
					echo '<td>';
						echo '<input type="checkbox" name="ids[]" value="'.$comment['id_koment'].'">';
						echo '<td>'.$comment['nazov'].'</td>';
						echo '<td>'.$comment['komentar'].'</td>';
						echo '<td>'.$comment['meno'].' '.$comment['priezvisko'].'</td>';
						echo '<td>'.$comment['cas'].'</td>';
						echo '</td>';
					echo '</tr>';
				}
				?>
				<tr>
				<td>
				<label for="akcia_a">schváľ</label
				><input type="radio" name="akcia" value="a" id="akcia_a" /> |
				<input type="radio" name="akcia" value="n" id="akcia_n" /><label
					for="akcia_n"
					>zamietni</label
				>
				<input type="submit" name="schval_zamietni" value="Potvrď" />
				</td>
				</tbody>
			</table>
		</form>
		<?php
	}

} else {
?>
	<form method="post">
		<p><label for="prihlasmeno">Prihlasovacie meno:</label> 
		<input name="prihlasmeno" type="text" size="30" maxlength="30" id="prihlasmeno" value="<?php if (isset($_POST["prihlasmeno"])) echo $_POST["prihlasmeno"]; ?>" ><br>
		<label for="heslo">Heslo:</label> 
		<input name="heslo" type="password" size="30" maxlength="30" id="heslo"> 
		</p>
		<p>
			<input name="submit" type="submit" id="submit" value="Prihlás ma">
		</p>
	</form>
<?php
}
?>
</section>
<?php include('paticka.php'); ?>
