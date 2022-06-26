const astronauts = await fetch("http://api.open-notify.org/astros.json").then(response => response.json());
[{ name: "NAME", craft: "CRAFT" }, ...astronauts.people].forEach(({ name, craft }) => {
  console.log("%s | %s", name.padStart(25, " "), craft.padStart(10, " "));
});
