// Configurações iniciais
jump_speed = -15;
max_horizontal_speed = 5;
max_vertical_speed = 20;

horizontal_speed = 0;
vertical_speed = 0;

ground = false;
state = MOVE_STATE.IDLE;

life = 100;
atack_cooldown = 0;
takes_damage = false;

// Enum para estados de movimento
enum MOVE_STATE {
    IDLE,
    WALK_RIGHT,
    WALK_LEFT,
    JUMP,
    ATACK
}

#region // Inicializa os controles
function initialize_controls() {
    global.key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
    global.key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
    global.key_jump = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
    global.key_fall = keyboard_check_released(vk_up) || keyboard_check_released(ord("W"));
    global.key_attack = keyboard_check_pressed(vk_space);
    global.key_run = keyboard_check(vk_shift);
}
#endregion

#region // Aplica o movimento horizontal
function apply_movement() {
    initialize_controls();

    // Define movimento horizontal e estado
    if (global.key_right) {
        horizontal_speed = max_horizontal_speed;
        image_xscale = 1;
        if (state != MOVE_STATE.ATACK) state = MOVE_STATE.WALK_RIGHT;
    }

    if (global.key_left) {
        horizontal_speed = -max_horizontal_speed;
        image_xscale = -1;
        if (state != MOVE_STATE.ATACK) state = MOVE_STATE.WALK_LEFT;
    }

    // Ataque
    if (global.key_attack && atack_cooldown <= 0) {
        state = MOVE_STATE.ATACK;
    }

    // Parado
    if (!global.key_right && !global.key_left) {
        horizontal_speed = 0;
        if (state != MOVE_STATE.ATACK) state = MOVE_STATE.IDLE;
    }

    // Movimentação com colisão
    if (place_meeting(x + horizontal_speed, y, obj_solid_block)) {
        horizontal_speed = 0;
    } else {
        x += horizontal_speed;
    }
}
#endregion

#region // Aplica movimento vertical
function apply_vertical_movement() {
    ground = place_meeting(x, y + 1, obj_solid_block);

    // Gravidade
    if (!ground) {
        vertical_speed = min(vertical_speed + 1, max_vertical_speed);
        if (state != MOVE_STATE.ATACK) state = MOVE_STATE.JUMP;
    } else if (global.key_jump) {
        vertical_speed = jump_speed;
    }

    // Colisão ao cair
    if (place_meeting(x, y + vertical_speed, obj_solid_block)) {
        while (!place_meeting(x, y + 1, obj_solid_block)) {
            y += 1;
        }
        vertical_speed = 0;
    }

    y += vertical_speed;
}
#endregion

#region // Atualiza sprite com base no estado
function change_sprite() {
    switch (state) {
        case MOVE_STATE.IDLE:
            sprite_index = spr_player_idle;
            break;
        case MOVE_STATE.WALK_RIGHT:
        case MOVE_STATE.WALK_LEFT:
            sprite_index = spr_player_walk;
            break;
        case MOVE_STATE.JUMP:
            sprite_index = spr_player_jump;
            break;
        case MOVE_STATE.ATACK:
            sprite_index = spr_player_atack;
            atack_cooldown = 50;

            // Aplicar impulso horizontal ao atacar
            if (image_xscale == 1) x += 5;
            else x -= 5;

            // Retorna ao estado anterior após ataque
            if (image_index >= sprite_get_number(sprite_index) - 1) {
                if (horizontal_speed == 0) state = MOVE_STATE.IDLE;
                else if (horizontal_speed > 0) state = MOVE_STATE.WALK_RIGHT;
                else state = MOVE_STATE.WALK_LEFT;
            }
            break;
        default:
            sprite_index = spr_player_idle;
            break;
    }

    image_speed = 1;
}
#endregion

#region // Atualiza o cooldown de ataque
function update_cooldowns() {
    if (atack_cooldown > 0) atack_cooldown--;
}
#endregion