<?php
$titulok = 'detail produktu';
session_start();
include('funkcie.php');
include('hlavicka.php');
include('navigacia.php');
include('akcia.php');

$product = get_product($mysqli, $_GET['prod']);

if ($product) {
	$issent = false;
	if (isset($_POST['komentar']))
	{
		$issent = add_comment($mysqli, $_GET['prod'], $_POST['komentar']);
	}

	if ($product['foto'] != "") {
		$foto_elem = "<img src='foto/". $product['foto'] ."' alt='".$product['nazov']."' width='130' height='130'>";
	} else {
		$foto_elem = "<span class='nophoto'> <p>No photo.</p> </span>";
	}
?>
<section>

	<h1><?php echo $product['nazov'] ?></h1>
	<?php echo $foto_elem ?>
	<p><?php echo $product['popis'] ?></p>
	<p>cena: <?php echo $product['cena'] ?> &euro;</p>
	<h2>Komentáre</h2>
	
	<ol>
		<?php
		foreach (get_comments($mysqli, $product['pid']) as $i => $com) {
			echo '<li>';
			echo '<p><strong>'.$com['meno'].' '.$com['priezvisko'].'</strong>: '.$com['komentar'].' ['.$com['cas'].']</p>';
			echo '</li>';
		}
		?>
	</ol>
	
	<?php
	if (isset($_SESSION['uid']))
	{
		if ($issent)
		{
			echo '<p>Komentar je pridany.</p>';
		}
	?>
		<form method="post">
			<p><label for="komentar">Pridaj komentár:</label>
			<textarea name="komentar" cols="60" rows="4" id="komentar"></textarea>
		</p>
		<p>
		<input name="submit" type="submit" id="submit" value="Pridaj komentár">
		</p>
		</form>
	<?php
	}
	?>
</section>

<?php 
} else {
	?>
	<section>
		<p class="chyba">Produkt neexistuje</p>
	</section>
	<?php
}
include('paticka.php');
?>
