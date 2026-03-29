// organoid-macro-ijm
// ImageJ/Fiji macro for semi-automated batch analysis of organoid growth

inputFolder = getDirectory("Select Input folder");
outputFolder = getDirectory("Select Output folder");

// Creazione sottocartelle di output
resultsFolder = outputFolder + "RESULTS" + File.separator;
jpegFolder = outputFolder + "JPEG" + File.separator;
roiFolder = outputFolder + "ROI" + File.separator;

File.makeDirectory(resultsFolder);
File.makeDirectory(jpegFolder);
File.makeDirectory(roiFolder);

fileList = getFileList(inputFolder);

for (i = 0; i < fileList.length; i++) {
    if (endsWith(fileList[i], "/")) continue; 
    
    open(inputFolder + fileList[i]);
    fileTitle = getTitle();
    imageName = replace(fileTitle, "\\.(tif|tiff|jpg|jpeg|png|gif|lif)$", ""); 
    rename(imageName);
    
    // Pre-processing
    run("Enhance Contrast...", "saturated=0.35 equalize");
    run("Unsharp Mask...", "radius=10 mask=0.60");
    run("Gaussian Blur...", "sigma=1");
    
    // Fase interattiva per la soglia (Threshold)
    setAutoThreshold("Default dark");
    run("Threshold...");
    waitForUser("Adjust threshold to be as representative as possible of the original image, then press OK.");
    
    setOption("BlackBackground", true);
    run("Convert to Mask");
    run("Open"); 
    
    // Configurazione misure (Area e Area Fraction per ottenere Count, Total Area, Average Size, %Area)
    run("Set Measurements...", "area area_fraction limit display redirect=["+imageName+"] decimal=2"); 
    run("Analyze Particles...", "size=200-Infinity display summarize add composite");
    
    // Salva Risultati Singoli
    selectWindow("Results");
    saveAs("Results", resultsFolder + imageName + ".csv");
    close("Results");
    
    // Salva Anteprima JPEG
    selectWindow(imageName);
    run("Flatten");
    saveAs("jpeg", jpegFolder + imageName + ".jpg");
    close(); 
    
    // Salva ROI e pulizia
    if (roiManager("count") > 0) {
        roiManager("Save", roiFolder + imageName + ".zip");
        roiManager("Delete");
    }
    
    close(imageName); 
}

// Salva il sommario finale (con Count, Total Area, Average Size, %Area)
if (isOpen("Summary")) {
    selectWindow("Summary");
    saveAs("Results", resultsFolder + "Summary_Total.csv");
    close("Summary");
}

showMessage("Batch processing is complete!");
