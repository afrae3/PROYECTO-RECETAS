<?php

$privateKeyFile = __DIR__ . '/private.pem';
$publicKeyFile = __DIR__ . '/public.pem';

$config = [
    "private_key_bits" => 2048,
    "private_key_type" => OPENSSL_KEYTYPE_RSA,
];

$res = openssl_pkey_new($config);

if (!$res) {
    die("Error generando la clave privada.\n");
}

openssl_pkey_export($res, $privateKey);
file_put_contents($privateKeyFile, $privateKey);

$keyDetails = openssl_pkey_get_details($res);
$publicKey = $keyDetails['key'];
file_put_contents($publicKeyFile, $publicKey);

echo "Claves generadas correctamente:\n";
echo "Privada: $privateKeyFile\n";
echo "Pública: $publicKeyFile\n";
