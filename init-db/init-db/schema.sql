-- ----------------------------
-- Table des Assistantes Maternelles
-- ----------------------------
CREATE TABLE IF NOT EXISTS assistantes_maternelles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telephone VARCHAR(20),
    salaire_horaire_brut DECIMAL(5,2) DEFAULT 3.64,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- Table des Parents
-- ----------------------------
CREATE TABLE IF NOT EXISTS parents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telephone VARCHAR(20),
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- Table des Enfants
-- ----------------------------
CREATE TABLE IF NOT EXISTS enfants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance DATE NOT NULL,
    id_parent INT NOT NULL,
    FOREIGN KEY (id_parent) REFERENCES parents(id) ON DELETE CASCADE
);

-- ----------------------------
-- Table des Horaires de Garde
-- ----------------------------
CREATE TABLE IF NOT EXISTS horaires_garde (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_assistante INT NOT NULL,
    id_enfant INT NOT NULL,
    date_garde DATE NOT NULL,
    heure_arrivee TIME NOT NULL,
    heure_depart TIME NOT NULL,
    heures_supplementaires DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (id_assistante) REFERENCES assistantes_maternelles(id) ON DELETE CASCADE,
    FOREIGN KEY (id_enfant) REFERENCES enfants(id) ON DELETE CASCADE
);

-- ----------------------------
-- Table des Repas et Frais Annexes
-- ----------------------------
CREATE TABLE IF NOT EXISTS frais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_horaire INT NOT NULL,
    repas INT DEFAULT 0,
    frais_entretien DECIMAL(6,2) DEFAULT 0,
    frais_transport DECIMAL(6,2) DEFAULT 0,
    description VARCHAR(255),
    FOREIGN KEY (id_horaire) REFERENCES horaires_garde(id) ON DELETE CASCADE
);

-- ----------------------------
-- Table des Fiches de Paie
-- ----------------------------
CREATE TABLE IF NOT EXISTS fiches_paie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_assistante INT NOT NULL,
    id_parent INT NOT NULL,
    periode_debut DATE NOT NULL,
    periode_fin DATE NOT NULL,
    heures_totales DECIMAL(6,2) DEFAULT 0,
    montant_brut DECIMAL(8,2) DEFAULT 0,
    montant_net DECIMAL(8,2) DEFAULT 0,
    montant_caf DECIMAL(8,2) DEFAULT 0,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_assistante) REFERENCES assistantes_maternelles(id),
    FOREIGN KEY (id_parent) REFERENCES parents(id)
);
