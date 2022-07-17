<?php 

	use PHPMailer\PHPMailer\PHPMailer;
	use PHPMailer\PHPMailer\SMTP;
	use PHPMailer\PHPMailer\Exception;

	require 'PHPMailer/src/Exception.php';
	require 'PHPMailer/src/PHPMailer.php';
	require 'PHPMailer/src/SMTP.php';
	
	require '../../modelo/modelo_usuario.php';

	$MU = new Modelo_Usuario();
	$email = htmlspecialchars($_POST['email'],ENT_QUOTES,'UTF-8');
	$contraactual= htmlspecialchars($_POST['contrasena'],ENT_QUOTES,'UTF-8');
	$contra = password_hash($_POST['contrasena'], PASSWORD_DEFAULT,['cost'=>10]);
	$consulta = $MU->Restablecer_Contra($email,$contra);
	if($consulta==1){


		$mail = new PHPMailer(true);

		try {
			$mail->SMTPOptions = array(
				'ssl' => array(
				'verify_peer' => false,
				'verify_peer_name' => false,
				'allow_self_signed' => true
				)
			);
		    $mail->SMTPDebug = 0;   
		    $mail->isSMTP();                     
		    $mail->Host       = 'smtp.gmail.com';            
		    $mail->SMTPAuth   = true;            
		    $mail->Username   = 'pruebamail034@gmail.com';                  
		    $mail->Password   = 'wwwwfrhhxpoxllmd';                           
		    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            
		    $mail->Port       = 465;                                  
		    //Recipients
		    $mail->setFrom('pruebamail034@gmail.com', 'andrew');
		    $mail->addAddress($email);     //Add a recipient

		    //Content
		    $mail->isHTML(true);                                  //Set email format to HTML
		    $mail->Subject = 'Restablecer password';
		    $mail->Body    = 'Su contraseña fue restablecida<br> Nueva contraseña: <b>'.$contraactual.'</b>';

		    $mail->send();
		    echo '1';
				} catch (Exception $e) {
		    		echo '0';
			}
			}else{
				echo '2';
	}
	
?>