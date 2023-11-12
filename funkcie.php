<?php
date_default_timezone_set('Europe/Bratislava');
include('db.php');

function vypis_select($min, $max, $oznac = -1) {
	for($i = $min; $i <= $max; $i++) {
		echo "<option value='$i'";
		if ($i == $oznac) echo ' selected';
		echo ">$i</option>\n";
	}
}

// vrati udaje pouzivatela ako asociativne pole, ak existuje pouzivatel $username s heslom $pass, inak vrati FALSE
function over_pouzivatela($mysqli, $username, $pass) {
	if (!$mysqli->connect_errno) {
		$hashed_pass = md5($pass); // pamatate ze mam zvlastne problemy z MD5 vo sql
		$escaped_username = $mysqli->real_escape_string($username);
		$sql = "SELECT * FROM coko_pouzivatelia WHERE username='$escaped_username' AND heslo='$hashed_pass'";  // definuj dopyt
		// echo "sql = $sql <br>";
		if (($result = $mysqli->query($sql)) && ($result->num_rows > 0)) {  // vykonaj dopyt
			// dopyt sa podarilo vykonať
			$row = $result->fetch_assoc();
			$result->free();
			return $row;
		} else {
			// dopyt sa NEpodarilo vykonať, resp. používateľ neexistuje!
			echo '<p class="chyba">Používateľ neexistuje alebo heslo nie je spravne!</p>';
			return false;
		}
	} else {
		// NEpodarilo sa spojiť s databázovým serverom!
		echo '<p class="chyba">Nepodarilo sa spojiť s databázovým serverom!</p>';
		return false;
	}
}

function get_produkty($mysqli) {
	$sql = "SELECT * FROM coko_produkty ORDER BY nazov";
	$produkty = array();

	if ($result = $mysqli->query($sql)) {
		while ($row = $result->fetch_assoc()) {
			array_push($produkty, $row);
		}
		$result->free();
	} elseif ($mysqli->errno) {
		echo '<p class="chyba"> Chyba načitania! </p>';
		return false;
	}

	return $produkty;
}

function get_product($mysqli, $id) {
	$sql = "SELECT * FROM coko_produkty WHERE pid=$id";

	if ($result = $mysqli->query($sql)) {
		$product = $result->fetch_assoc();
		$result->free();
	} elseif ($mysqli->errno) {
		echo '<p class="chyba"> Chyba načitania! </p>';
		return false;
	}

	return $product;
}

function get_comments($mysqli, $prodid) {
	$escaped_prodid = $mysqli->real_escape_string($prodid);
	$sql = "SELECT `coko_komentare`.*,`username`, `meno`, `priezvisko` FROM `coko_komentare` INNER JOIN `coko_pouzivatelia` ON `coko_komentare`.`uid` = `coko_pouzivatelia`.`uid` WHERE `pid`=$escaped_prodid AND `stav`='a' ORDER BY `cas` DESC";
	$comments = array();

	if ($result = $mysqli->query($sql)) {
		while ($row = $result->fetch_assoc()) {
			array_push($comments, $row);
		}
		$result->free();
	} elseif ($mysqli->errno) {
		echo '<p class="chyba"> Chyba načitania! </p>';
		return false;
	}

	return $comments;
}

function add_comment($mysqli, $prodid, $text)
{
	$uid = $_SESSION['uid'];
	
	if (isset($uid) && get_product($mysqli, $prodid)) {
		$escaped_text = $mysqli->real_escape_string($text);
		$escaped_uid = $mysqli->real_escape_string($uid);

		$sql = "INSERT INTO `coko_komentare` (`uid`, `pid`, `komentar`, `cas`, `stav`) VALUES ('$uid', '$prodid', '$escaped_text', NOW(), 'x')";

		if ($mysqli->query($sql)) {
			return true;
		} else {
			echo '<p class="chyba"> Chyba pridania komentaria! </p>';
			return false;
		}

		return true;
	} else {
		echo '<p class="chyba">Kto ste?</p>';
		return false;
	}
}

function get_all_comments($mysqli)
{
	$sql = "SELECT * FROM `coko_komentare` as koms INNER JOIN `coko_pouzivatelia` as users ON koms.uid = users.uid INNER JOIN `coko_produkty` as prods ON koms.pid = prods.pid WHERE koms.stav='x'";
	$comments = array();

	if ($result = $mysqli->query($sql)) {
		while ($row = $result->fetch_assoc()) {
			array_push($comments, $row);
		}
		$result->free();
	} elseif ($mysqli->errno) {
		echo '<p class="chyba"> Chyba načitania! </p>';
		return false;
	}

	return $comments;
}

function modify_comment_state($mysqli, $comment_ids, $state)
{
	if (!$_SESSION['admin'])
	{
		echo '<p class="chyba">Nie ste admin!</p>';
		return false;
	}

	$string_ids = implode(', ', $comment_ids);
	$escaped_ids = $mysqli->real_escape_string($string_ids);
	$escaped_state = $mysqli->real_escape_string($state);

	$sql = "UPDATE `coko_komentare` SET `stav`='$escaped_state' WHERE `id_koment` IN ($escaped_ids)";

	if ($mysqli->query($sql)) {
		return true;
	} else {
		echo '<p class="chyba"> Chyba modifikovania stavu! </p>';
		return false;
	}
}
?>
