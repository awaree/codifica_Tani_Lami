<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output 
        method="html" 
        encoding="UTF-8" 
        indent="yes"
        omit-xml-declaration="yes" />
    
    <xsl:template match="/tei:teiCorpus">
        <html>
            <head>
                <title> Cartoline </title>
                <link href="stile.css" rel="stylesheet" type="text/css"/>
                <link href="https://fonts.googleapis.com/css?family=Arvo" rel="stylesheet"/>
                <link href="https://fonts.googleapis.com/css?family=Dawning+of+a+New+Day" rel="stylesheet"/>
                <link href="https://fonts.googleapis.com/css?family=Thasadith" rel="stylesheet"/>
                <link rel="shortcut icon" type="image/x-icon" href="pen.png" />
            </head>
            <body>
                <nav id="top"/>
                <xsl:apply-templates/>
                <a href="#top"><img src="freccia_su.png" alt="freccia" id="freccia"/></a>
                <footer>
                    Sito realizzato da Giorgia Tani e Maria Vittoria Lami per il corso di <p id="corsivo">codifica di testi</p>.
                </footer>
            </body> 
        </html>
    </xsl:template>
    
    <!-- Regola che crea un div con un id contenente i metadati del file cartoline.xml -->
    <xsl:template match="tei:teiCorpus/tei:teiHeader">
        <h1>Informazioni sui documenti</h1>
        <div id="metadati_principali">
            <xsl:apply-templates/>
        </div>
        <h1>Cartoline</h1>
    </xsl:template>
    
    <!-- Regola generale per andare a capo-->
    
    <xsl:template match="tei:lb"> 
        <br/> <xsl:if test="./@n">
            <span class="line">
                <xsl:value-of select="current()/@n" />
            </span>
        </xsl:if>
    </xsl:template>
    
    <!-- Regole per andare a capo all'interno dei metadati -->
    
    <xsl:template match="tei:titleStmt">
        <xsl:for-each select="tei:title">
            <h4 id="titolo_metadati">
                <xsl:apply-templates/>
            </h4>
        </xsl:for-each>
        <xsl:for-each select="tei:respStmt/tei:resp">
            <br>
                <xsl:apply-templates/>
            </br>
        </xsl:for-each>
        <xsl:for-each select="tei:respStmt/tei:name">
            <br>
                <xsl:apply-templates/>
            </br>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:editionStmt">
        <br><br>
            <xsl:apply-templates/>
        </br></br>
    </xsl:template>
    
    <xsl:template match="tei:edition">
        <br>
            <xsl:apply-templates/>
        </br>
    </xsl:template>
    
    <xsl:template match="tei:respStmt">
        <br>
            <xsl:apply-templates/>
        </br>
    </xsl:template>
    
    <xsl:template match="tei:publicationStmt">
        <br><br>
            <xsl:apply-templates/>
        </br></br>
    </xsl:template>
    
    <xsl:template match="tei:sourceDesc">
        <br><br>
            <xsl:apply-templates/>
        </br></br>
    </xsl:template>
    
    <!-- Regola che trasforma in paragrafi il contenuto dei div presenti nei file xml -->

    <xsl:template match="tei:div">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <!-- Regola che inserisce in un paragrafo i titoli delle immagini raffigurate sulle cartoline assegnando loro un id -->
    <xsl:template match="tei:head">
        <p id="titolo">
            <xsl:apply-templates />
        </p>
    </xsl:template>
    
    <!-- Regole per le visualizzazioni delle <choice> -->
    
    <xsl:template match="tei:sic">
        <p id='sbagliato'>[<xsl:apply-templates />]</p>
    </xsl:template>
    
    <xsl:template match="tei:corr">
        <p id='corretto'>[<xsl:apply-templates />]</p>
    </xsl:template>
    
    <xsl:template match="tei:orig">
        <p id='sbagliato'>[<xsl:apply-templates />]</p>
    </xsl:template>
    
    <xsl:template match="tei:reg">
        <p id='corretto'>[<xsl:apply-templates />]</p>
    </xsl:template>
    
    <xsl:template match="tei:abbr">
        <p id='sbagliato'>[<xsl:apply-templates/>]</p>
    </xsl:template>
    
    <xsl:template match="tei:expan">
        <p id='corretto'>[<xsl:apply-templates/>]</p>
    </xsl:template>
    
    <!-- Regola per sottolineare il contenuto di <hi> -->
    
    <xsl:template match="tei:hi">
        <xsl:if test="@rend='underline'">
            <u><xsl:apply-templates/></u>
        </xsl:if>
    </xsl:template>
    
    <!-- Regola per mettere in grassetto i titoli delle immagini raffigurate sulle cartoline -->
    
    <xsl:template match="tei:title">
        <xsl:if test="@xml:id='titolo_immagine56' or @xml:id='titolo_immagine59' or @xml:id='titolo_immagine68'">
            <b><xsl:apply-templates/></b>
        </xsl:if>
    </xsl:template>
    
    <!-- Regole per inserire le immagini contenute nei <surface> dentro a un div con una class --> 
    
    <xsl:template match="tei:surface[@xml:id='fronte56' or @xml:id='fronte59' or @xml:id='fronte68']/tei:graphic">
        <div class="immagine_davanti"><img src="{@url}" id='fronte'/></div>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:surface[@xml:id='retro56' or @xml:id='retro59' or @xml:id='retro68']/tei:graphic">
        <div class="immagine_retro"><img src="{@url}" id='retro'/></div>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Regola per dividere il codice in div -->
    
    <xsl:template match="tei:TEI">
        <div class="blocco"> <!-- Creazione di un div per ogni file incluso in cartoline.xml -->
            
            <xsl:for-each select="tei:teiHeader">
                <div class="metadati"> <!-- Creazione di un div contenente i metadati di ogni file incluso in cartoline.xml -->
                    <xsl:value-of select="tei:teiHeader"/>
                    <xsl:apply-templates/>
                </div>
            </xsl:for-each>
            
            <xsl:for-each select="tei:text/tei:body">
                <div class="cartolina_trascritta"> <!-- Creazione di un div contenente il <body> di ogni file incluso in cartoline.xml -->
                    
                    <xsl:for-each select="tei:div[@xml:id='cartolina_fronte56' or @xml:id='cartolina_fronte59' or @xml:id='cartolina_fronte68']">
                        <div class="descrizione_immagine">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:for-each>
                    
                    <xsl:for-each select="tei:div[@xml:id='cartolina_retro56' or @xml:id='cartolina_retro59' or @xml:id='cartolina_retro68']">
                        <div class="contenuto">
                            
                            
                            <xsl:for-each select="tei:div[@xml:id='message56' or @xml:id='message59' or @xml:id='message68']">
                                <div class="scrittoamano">
                                    <xsl:for-each select="tei:div[@xml:id='testo56' or @xml:id='testo59' or @xml:id='testo68']">
                                        <div class="testo">
                                            <xsl:apply-templates/>
                                        </div>
                                    </xsl:for-each>
                                    
                                    <xsl:for-each select="tei:div[@xml:id='indirizzo56' or @xml:id='indirizzo59' or @xml:id='indirizzo68']">
                                        <div class="indirizzo">
                                            <xsl:apply-templates/>
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </xsl:for-each>
                            
                            <xsl:for-each select="tei:div[@xml:id='destination56' or @xml:id='destination59' or @xml:id='destination68']">
                                <div class="destination">
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:for-each>
                            
                        </div>
                    </xsl:for-each>
                    
                </div>
            </xsl:for-each>
            <div class="gruppo_immagini"> <!-- Creazione di un div contenente le immagini di ogni file incluso in cartoline.xml -->
                <xsl:for-each select="tei:facsimile"><br></br>
                    <xsl:apply-templates/>
                </xsl:for-each><br></br>
            </div>
            
        </div>    
    </xsl:template>
    
</xsl:stylesheet>