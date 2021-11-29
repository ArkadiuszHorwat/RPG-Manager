import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterModel {
  CharacterModel({
    this.name,
    this.system,
    this.image,
    this.userId,
    this.timestamp,
    this.characterId,
    this.characterPD,
    this.characterActiveCampaign,
    this.characterLvl,
    this.deathCheck,
    this.lifeCheck,
    this.characterBio,
    this.characterRace,
    this.characterClass,
    this.characterAlignment,
    this.characterCharisma,
    this.characterStrength,
    this.characterDexterity,
    this.characterConstitution,
    this.characterIntelligence,
    this.characterWisdom,
    this.sM,
    this.sS,
    this.sE,
    this.sZ,
    this.sP,
    this.attacksAndMagic,
    this.spellBaseAttribute,
    this.countSpellCells,
    this.spellCellsUsed,
    this.throwAgainstSpells,
    this.magicAttackBonus,
    this.speed,
    this.initiative,
    this.perception,
    this.maxPW,
    this.tempPW,
    this.characterKP,
    this.inspiration,
    this.specialBonus,
    this.characterKW,
    this.defenseThrowsCharisma,
    this.defenseThrowsWisdom,
    this.defenseThrowsIntelligence,
    this.defenseThrowsConstitution,
    this.defenseThrowsDexterity,
    this.defenseThrowsStrength,
  });

  final String? name;
  final String? system;
  final String? image;
  final String? userId;
  final Timestamp? timestamp;

  final String? characterId;
  final String? characterPD;
  final String? characterActiveCampaign;
  final int? characterLvl;
  final int? deathCheck;
  final int? lifeCheck;
  final String? characterBio;
  final String? characterRace;
  final String? characterClass;
  final String? characterAlignment;
  final String? characterCharisma;
  final String? characterStrength;
  final String? characterDexterity;
  final String? characterConstitution;
  final String? characterIntelligence;
  final String? characterWisdom;
  final String? sM;
  final String? sS;
  final String? sE;
  final String? sZ;
  final String? sP;
  final String? attacksAndMagic;
  final String? spellBaseAttribute;
  final String? countSpellCells;
  final String? spellCellsUsed;
  final String? throwAgainstSpells;
  final String? magicAttackBonus;
  final String? speed;
  final String? initiative;
  final String? perception;
  final String? maxPW;
  final String? tempPW;
  final String? characterKP;
  final String? inspiration;
  final String? specialBonus;
  final String? characterKW;
  final String? defenseThrowsCharisma;
  final String? defenseThrowsWisdom;
  final String? defenseThrowsIntelligence;
  final String? defenseThrowsConstitution;
  final String? defenseThrowsDexterity;
  final String? defenseThrowsStrength;
}
