<?php
$titulok = 'Ponuka';
include('funkcie.php');
include('hlavicka.php');
include('navigacia.php');
include('akcia.php');
?>
<section>
<?php echo "<h1>$titulok</h1>"; ?>

<div id="products">

    <?php
    foreach (get_produkty($mysqli) as $i => $product) {
        if ($product['foto'] != "") {
            $foto_elem = "<img src='foto/". $product['foto'] ."' alt='".$product['nazov']."' width='130' height='130'>";
        } else {
            $foto_elem = "<span class='nophoto'> <p>No photo.</p> </span>";
        }
        
        echo '<a href="detail.php?prod='.$product['pid'].'">';
        echo "<figure>";
        echo "<figcaption>".$product['nazov']."</figcaption>";
        echo $foto_elem;
        echo "<p>cena:".$product['cena']." &euro;</p>";
        echo "</figure>";
        echo "</a>";
    }
    ?>
    
    <div id="posledny"></div>
</div>
</section>
<?php include('paticka.php'); ?>
