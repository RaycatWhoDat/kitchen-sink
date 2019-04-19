#!/usr/bin/env rdmd 

module scryfall;

import std.stdio: write, writeln;
import std.net.curl: get, HTTPStatusException;
import std.json: parseJSON, JSONValue, JSONException;
import std.getopt: getopt;
import std.uri: encode;

const INFO_NO_CARDS_FOUND = "No cards found.";
const INFO_SEARCHING_FOR = "Searching for: ";
const ERR_API_FAILURE = "There was an error accessing Scryfall's services. Returning no results.";

string accessFieldValue(JSONValue card, string fieldName) {
  try {
    return card[fieldName].str;
  } catch (JSONException exception) {
    return "";
  }
}

void printCard(JSONValue cardFace, JSONValue otherCardFace = JSONValue(null)) {
    string name = accessFieldValue(cardFace, "name");
    string manaCost = accessFieldValue(cardFace, "mana_cost");
    string typeLine = accessFieldValue(cardFace, "type_line");
    string oracleText = accessFieldValue(cardFace, "oracle_text");
    string power = accessFieldValue(cardFace, "power");
    string toughness = accessFieldValue(cardFace, "toughness");
    
    writeln(name, " ", manaCost);
    writeln(typeLine);
    if (!otherCardFace.isNull) writeln("(This card transforms into ", otherCardFace["name"].str, ".)");
    if (oracleText.length) writeln(oracleText);
    if (power.length || toughness.length) writeln(power != "" ? power : "-", "/", toughness != "" ? toughness : "-");
    writeln();
}

void cardSearch(string query = "") {
  if (!query.length) return writeln(INFO_NO_CARDS_FOUND);
  writeln(INFO_SEARCHING_FOR ~ query);

  JSONValue[] searchResults;
  
  try {
    JSONValue searchResponse = parseJSON(get("https://api.scryfall.com/cards/search?q=" ~ encode(query)));
    searchResults = searchResponse["data"].array;
  } catch (HTTPStatusException exception) {
    if (exception.status == 404) return writeln(INFO_NO_CARDS_FOUND);
    return writeln(ERR_API_FAILURE);
  }

  foreach (card; searchResults) {
    try {
      JSONValue cardFaces = card["card_faces"].array;
      printCard(cardFaces[0], cardFaces[1]);
      printCard(cardFaces[1], cardFaces[0]);
    } catch (JSONException exception) {
      printCard(card);
    }
  }
}

void main(string[] args) {
  string query;
  getopt(args, "query", &query);
  cardSearch(query);
}

// Local Variables:
// compile-command: "./scryfall.d --query 'alpha'"
// End:
