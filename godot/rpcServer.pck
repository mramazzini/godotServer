GDPC                P                                                                         P   res://.godot/exported/206107301/export-218a8f2b3041327d8a5756f3a245f83b-icon.res      '      x]!�?O�坆�^q�TC    T   res://.godot/exported/206107301/export-36a25e342948d0ceacc500772b5412b3-player.scn  �      k      �G��"�9���Q�^    P   res://.godot/exported/206107301/export-609f762188a68253d349ec58c4f3a8d3-game.scn        ;      ��־��Cr���A�    ,   res://.godot/global_script_class_cache.cfg         �       ��(92�k[����5       res://.godot/uid_cache.bin  P      V       i��Hյ�'�* ��
�       res://MultiplayerSpawner.gd @      �      ��L�sQ+���[ �{       res://Server.gd        �      &9�̅���E�m�r��       res://game.tscn.remap          a       B�x�y�c@�gE��       res://icon.svg  �      �      C��=U���^Qu��U3       res://icon.svg.import   @      �       T�eE�?عوf�QUl�       res://player.gd @      f       }���Ӱ6���H�C�[       res://player.tscn.remap �      c       je�n�
^�����0�       res://project.binary�      #      �u�PK�7r�6�    RSRC                    PackedScene            ��������                                                  ..    resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Server.gd ��������   Script    res://MultiplayerSpawner.gd ��������   PackedScene    res://player.tscn yl�����]      local://PackedScene_mgvib o         PackedScene          	         names "         Game    Node3D    Server    script    ServerInfo    HTTPRequest    World    MultiplayerSpawner    spawn_path    player #   _on_http_request_request_completed    request_completed    	   variants                                                   node_count             nodes     +   ��������       ����                      ����                            ����                      ����                      ����               	                conn_count             conns                 
                    node_paths              editable_instances              version             RSRC     [remap]

importer="texture"
type="PlaceholderTexture2D"
uid="uid://c4pdcftc76006"
metadata={
"vram_texture": false
}
path="res://.godot/exported/206107301/export-218a8f2b3041327d8a5756f3a245f83b-icon.res"
   RSRC                    PlaceholderTexture2D            ��������                                                  resource_local_to_scene    resource_name    size    script        #   local://PlaceholderTexture2D_jn120 �          PlaceholderTexture2D       
      C   C      RSRC         extends MultiplayerSpawner

@export var player: PackedScene

func _init() -> void:
	spawn_function = _spawn_custom

func _spawn_custom(data: Variant) -> Node:
	var scene: Player = player.instantiate() as Player
	scene.peer_id = data.peer_id
	scene.initial_transform = data.initial_transform
	# Lots of other helpful init things you can do here: e.g.
	scene.is_master = multiplayer.get_unique_id() == data.peer_id
	scene.set_multiplayer_authority(data.peer_id)
	scene.name = str(data.peer_id)
	return scene
      extends Node3D

class_name Player

var is_master: bool
var initial_transform: Transform3D
var peer_id
          RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://player.gd ��������      local://PackedScene_rvp6f          PackedScene          	         names "         Player    script    Node3D    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC     extends Node3D
var url = "http://localhost:3001" # "https://godotserver-cbc793237a9a.herokuapp.com/"
@onready var api:= $"../ServerInfo"
var PORT:int
var serverHost:String
var serverName:String
var mongoID:String
const EXPIRE_TIME = 60000 * 10
@onready var spawner = $"../MultiplayerSpawner"
var valid:bool = false
var connectedIDS = []
func _ready():
	# Retrieve server info from REST api
	var headers = ["Content-Type: application/json"]
	api.request(url + "/pop", headers, HTTPClient.METHOD_DELETE)
	print("Sending api request")
func _process(delta):
	if EXPIRE_TIME <= Time.get_ticks_msec():
		print("server expired")
		get_tree().quit()
func startServer():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, 4)
	multiplayer.multiplayer_peer = peer
	peer.peer_connected.connect(
		func(new_peer_id):
			await get_tree().create_timer(1).timeout
			rpc("addJoinedPlayer", new_peer_id)
			rpc_id(new_peer_id, "addPrevJoinedPlayer", connectedIDS)
			addPlayer(new_peer_id)
	)
	print("Server listening on PORT: ", PORT)

func _on_http_request_request_completed(result, response_code, headers, body):
	# Once data is retrieved, we can activate the server on the given PORT
	print("Api recieved!")
	var json = JSON.parse_string(body.get_string_from_utf8())
	PORT = json["port"]
	serverHost = json["owner"]
	mongoID = json["_id"]
	serverName = json["name"]
	if PORT && serverHost && mongoID && serverName:
		valid = true
		print("Starting server")
		startServer()
	else:
		print("invalid json data, reading", json)


func addPlayer(peerID = 1):
	connectedIDS.append(peerID)
	spawner.spawn({ 'peer_id': peerID, 'initial_transform': global_transform })
	

@rpc("call_remote")
func addJoinedPlayer(newPeerID):
	pass
@rpc("call_remote")
func addPrevJoinedPlayer(playerIDS:Array):
	pass
 [remap]

path="res://.godot/exported/206107301/export-609f762188a68253d349ec58c4f3a8d3-game.scn"
               [remap]

path="res://.godot/exported/206107301/export-36a25e342948d0ceacc500772b5412b3-player.scn"
             list=Array[Dictionary]([{
"base": &"Node3D",
"class": &"Player",
"icon": "",
"language": &"GDScript",
"path": "res://player.gd"
}])
            <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             ��6E	   res://game.tscnMuG*I��^   res://icon.svgyl�����]   res://player.tscn          ECFG      _custom_features         dedicated_server   application/config/name      	   rpcServer      application/run/main_scene         res://game.tscn    application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg               