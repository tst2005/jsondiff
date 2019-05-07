# jsondiff

A jsondiff tool.

* [samples/a.json](samples/a.json) and [samples/b.json](samples/b.json)

```json
{
  "People": ["John", "Bryan"],
  "City": "Boston",
  "State": "MA"
}
```

* [samples/c.json](samples/c.json)

```json
{
  "People": ["John", "Bryan", "Carla"],
  "City": "Boston",
  "State": "MA"
}
```

* [samples/d.json](samples/d.json)

```json
{
  "People": ["John", "Bryan", "Carla"],
  "City": "Boston",
  "State": "ElseWhere"
}
```

# sample of use

```bash
[ano@nymous]~/jsondiff$ ./bin/jsondiff.via-lib samples/a.json samples/b.json # same content, no diff
```

```bash
[ano@nymous]~/jsondiff$ ./bin/jsondiff.via-lib samples/a.json samples/c.json
["+", {".People[]":"Carla"}]
```

```bash
[ano@nymous]~/jsondiff$ ./bin/jsondiff.via-lib samples/a.json samples/d.json
["+", {".People[]":"Carla"}]
["-", {".State":"MA"}]
["+", {".State":"ElseWhere"}]
```

