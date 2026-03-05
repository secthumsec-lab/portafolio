<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
set_time_limit(300);

$baseDir = __DIR__;
$downloadUrl = 'https://suitecrm.com/download/166/suite89/566057/suitecrm-8-9-2.zip';
$zipFile = $baseDir . '/suitecrm.zip';
$extractDir = $baseDir . '/suitecrm-extract';

function downloadFile($url, $dest) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, 300);
    curl_setopt($ch, CURLOPT_PROGRESSFUNCTION, function($resource, $download_size, $downloaded_size, $upload_size, $uploaded_size) {
        if ($download_size > 0) {
            $percent = ($downloaded_size / $download_size) * 100;
            echo "Progreso: " . round($percent, 1) . "% (" . round($downloaded_size / 1024 / 1024, 1) . "MB / " . round($download_size / 1024 / 1024, 1) . "MB)\n";
            flush();
        }
    });
    curl_setopt($ch, CURLOPT_NOPROGRESS, false);
    
    $data = curl_exec($ch);
    $error = curl_error($ch);
    curl_close($ch);
    
    if ($error) {
        throw new Exception("Error descargando: " . $error);
    }
    
    if (file_put_contents($dest, $data) === false) {
        throw new Exception("Error guardando archivo: " . $dest);
    }
    
    return filesize($dest);
}

?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SuiteCRM Installer</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .step { margin: 20px 0; padding: 15px; border: 1px solid #ccc; border-radius: 5px; }
        .success { background: #d4edda; border-color: #c3e6cb; }
        .error { background: #f8d7da; border-color: #f5c6cb; }
        .info { background: #d1ecf1; border-color: #bee5eb; }
        button { padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer; border-radius: 3px; }
        button:hover { background: #0056b3; }
        pre { background: #f5f5f5; padding: 10px; overflow-x: auto; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 SuiteCRM 8.9.2 - Instalador</h1>
        
        <?php if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])): ?>
            <div class="step info">
                <h2>Procesando instalación...</h2>
                <pre>
<?php
                try {
                    if ($_POST['action'] === 'download') {
                        echo "📥 Descargando SuiteCRM 8.9.2...\n";
                        $size = downloadFile($downloadUrl, $zipFile);
                        echo "\n✅ Descargado: " . round($size / 1024 / 1024, 1) . " MB\n";
                        $_SESSION['step'] = 'extract';
                    }
                    
                    if ($_POST['action'] === 'extract' || $_SESSION['step'] === 'extract') {
                        echo "📦 Extrayendo archivos...\n";
                        
                        if (!file_exists($zipFile)) {
                            throw new Exception("Archivo ZIP no encontrado");
                        }
                        
                        $zip = new ZipArchive();
                        if ($zip->open($zipFile) !== true) {
                            throw new Exception("Error abriendo ZIP");
                        }
                        
                        if (!is_dir($extractDir)) {
                            mkdir($extractDir, 0755, true);
                        }
                        
                        $zip->extractTo($extractDir);
                        $zip->close();
                        
                        echo "✅ Archivos extraídos\n";
                        $_SESSION['step'] = 'move';
                    }
                    
                    if ($_POST['action'] === 'move' || $_SESSION['step'] === 'move') {
                        echo "📋 Moviendo archivos...\n";
                        
                        $srcDir = $extractDir . '/SuiteCRM-8.9-stable';
                        if (!is_dir($srcDir)) {
                            // Probar estructura alternativa
                            $files = scandir($extractDir);
                            foreach ($files as $file) {
                                if ($file !== '.' && $file !== '..' && is_dir($extractDir . '/' . $file) && strpos($file, 'Suite') !== false) {
                                    $srcDir = $extractDir . '/' . $file;
                                    break;
                                }
                            }
                        }
                        
                        if (!is_dir($srcDir)) {
                            throw new Exception("Directorio fuente no encontrado: " . $srcDir);
                        }
                        
                        // Mover archivos
                        $files = scandir($srcDir);
                        foreach ($files as $file) {
                            if ($file !== '.' && $file !== '..') {
                                $src = $srcDir . '/' . $file;
                                $dst = $baseDir . '/' . $file;
                                
                                if (is_dir($src)) {
                                    if (!is_dir($dst)) mkdir($dst, 0755, true);
                                    $this_files = new RecursiveIteratorIterator(
                                        new RecursiveDirectoryIterator($src),
                                        RecursiveIteratorIterator::SELF_FIRST
                                    );
                                    foreach ($this_files as $file_obj) {
                                        $rel = substr($file_obj, strlen($src) + 1);
                                        if (is_dir($file_obj)) {
                                            @mkdir($dst . '/' . $rel);
                                        } else {
                                            @copy($file_obj, $dst . '/' . $rel);
                                        }
                                    }
                                } else {
                                    copy($src, $dst);
                                }
                            }
                        }
                        
                        echo "✅ Archivos movidos\n";
                        
                        // Limpiar
                        echo "🧹 Limpiando temporales...\n";
                        @unlink($zipFile);
                        $this_files = new RecursiveIteratorIterator(
                            new RecursiveDirectoryIterator($extractDir),
                            RecursiveIteratorIterator::CHILD_FIRST
                        );
                        foreach ($this_files as $file) {
                            if ($file->isFile()) {
                                @unlink($file);
                            } elseif ($file->isDir()) {
                                @rmdir($file);
                            }
                        }
                        @rmdir($extractDir);
                        
                        echo "\n✅ Instalación completada!\n";
                        echo "\n📍 SuiteCRM está ahora disponible en http://localhost:8080\n";
                        $_SESSION['step'] = 'complete';
                    }
                } catch (Exception $e) {
                    echo "\n❌ Error: " . $e->getMessage() . "\n";
                    echo "\nPor favor, intenta de nuevo.\n";
                }
?>
                </pre>
            </div>
        <?php else: ?>
            <div class="step info">
                <h2>Instalación de SuiteCRM 8.9.2</h2>
                <p>Este instalador descargará e instalará SuiteCRM automáticamente.</p>
                <form method="POST">
                    <input type="hidden" name="action" value="download">
                    <button type="submit">▶ Comenzar Instalación</button>
                </form>
            </div>
            
            <div class="step">
                <h3>Requisitos:</h3>
                <ul>
                    <li><?php echo extension_loaded('curl') ? '✅' : '❌'; ?> cURL</li>
                    <li><?php echo extension_loaded('zip') ? '✅' : '❌'; ?> ZIP</li>
                    <li><?php echo extension_loaded('mysqli') ? '✅' : '❌'; ?> MySQLi</li>
                    <li><?php echo is_writable($baseDir) ? '✅' : '❌'; ?> Permisos de escritura</li>
                </ul>
            </div>
        <?php endif; ?>
    </div>
</body>
</html>
