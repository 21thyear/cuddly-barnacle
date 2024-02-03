DialogCreate:dRegister(playerid)
{
    Dialog_Open(playerid, Dialog:dRegister, DIALOG_STYLE_PASSWORD,
        "{FFFFFF} >> Регистрация | {FFD500} Ukraine Project!",
        
        "{FFFFFF} Добро пожаловать на игровой проект {FFD500} Ukraine Project!\n\
        {FFFFFF} Чтобы продолжить, вам необходимо зарегистрироваться.\n\
        {FFFFFF} Введите пароль, для Вашего аккаунта.\n\
        \n\
        {005bbb} Примечание: \n\
        {005bbb} - Пароль может состоять только из латинских букв и цифр\n\
        {005bbb} - Длина пароля от 6-12 символов\n\
        {005bbb} - Используйте цифры и заглавные буквы для усложнения пароля",

        "Далее", "Выход");
}
 
DialogResponse:dRegister(playerid, response, listitem, inputtext[])
{
    if (!response) {
        return Kick(playerid);
    }
 
    if (strlen(inputtext) < 6 || strlen(inputtext) > 12)
    {
        return Dialog_Show(playerid, Dialog:dRegister); 
    }

    for(new i = 0, j = strlen(inputtext); i <= j && inputtext[i] != EOS; i++)
    {
        switch(inputtext[i])
        {
            case 'а'..'я', 'А'..'Я', '@', '!', '/':
            {
                SendClientMessage(playerid, COLOR_RED, !"{d30000} Пароль не может состоять из символов! Повторите попытку.");
                return Dialog_Show(playerid, Dialog:dRegister); 
            }
            default:
            {
                return bcrypt_hash(inputtext, BCRYPT_COST, "OnPasswordHashed", "d", playerid);
            }
        }
    }

    return 1;
}

DialogCreate:dEmail(playerid)
{
    Dialog_Open(playerid, Dialog:dEmail, DIALOG_STYLE_INPUT,
        "{FFFFFF} >> Регистрация | {FFD500} Ukraine Project!",
        "{FFFFFF} Ввод почты!\n\
        Используйте его, чтобы восстановить доступ к аккаунту в случае взлома или если забудете пароль.\n\
        Проверьте правильность ввода и нажмите кнопку \"Далее\"",
        "Далее", "Отмена");
}
DialogResponse:dEmail(playerid, response, listitem, inputtext[])
{
    if(!response) {
        return Dialog_Show(playerid, Dialog:dRegister);
    }

    if (strlen(inputtext) < 10 || strlen(inputtext) > MAX_PLAYER_EMAIL)
    {
        SendClientMessage(playerid, -1, "{d30000} Неправильно введена почта! Повторите попытку.");
        return Dialog_Show(playerid, Dialog:dEmail);
    }

    if(!IsValidEmail(inputtext)) 
    {
        SendClientMessage(playerid, -1, "{d30000} Неправильно введена почта! Повторите попытку.");
        return Dialog_Show(playerid, Dialog:dEmail);
    }

    for(new i = 0, j = strlen(inputtext); i <= j && inputtext[i] != EOS; i++)
    {
        switch(inputtext[i])
        {
            case 'а'..'я', 'А'..'Я':
            {
                return Dialog_Show(playerid, Dialog:dEmail); 
            }
            default:
            {
                strins(PlayerInfo[playerid][pEmail], inputtext, 0);
                return Dialog_Show(playerid, Dialog:dSex);
            }
        }
    }

    return true;
}

DialogCreate:dPromocode(playerid)
{
    Dialog_Open(playerid, Dialog:dPromocode, DIALOG_STYLE_INPUT,
                "{FFFFFF} >> Регистрация | {FFD500} Ukraine Project!",
                "\
{FFFFFF} Чтобы получить бонусы на 5-м уровне, после прохождения квестов.\n\
{FFFFFF} Введите \"Имя_Фамилию\" друга или \"промокод\" Ютубера.",
                "Далее", "Пропустить");
}

DialogResponse:dPromocode(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        return RegisterPlayer(playerid);
    }

    switch(inputtext[0])
    {
        case '#':
        {
            if(strlen(inputtext) < 3 || strlen(inputtext) > MAX_PLAYER_PROMO)
                return Dialog_Show(playerid, Dialog:dPromocode);

            new fmt_query[] = "SELECT pName FROM `promocodes` WHERE `pName` = '%s' LIMIT 1";
            new query[sizeof fmt_query + MAX_PLAYER_PROMO + (-2) + 1];

            format(query, sizeof(query), fmt_query, inputtext);

            new Cache:result = mysql_query(dbHandle, query);
            new rows = cache_num_rows();

            if(!rows)
            {
                SendClientMessage(playerid, COLOR_RED, !" Промокод не найден!");
                cache_delete(result);

                return Dialog_Show(playerid, Dialog:dPromocode);
            }
            else
            {
                strins(PlayerInfo[playerid][pPromocode], inputtext, 0);
            }
        }
        default:
        {
            if(strlen(inputtext) < 6 || strlen(inputtext) > MAX_PLAYER_NAME)
                return Dialog_Show(playerid, Dialog:dPromocode);
            
            new fmt_query[] = "SELECT uName FROM `accounts` WHERE `uName` = '%s' LIMIT 1";
            new query[sizeof fmt_query + MAX_PLAYER_NAME + (-2) + 1];

            format(query, sizeof(query), fmt_query, inputtext);

            new Cache:result = mysql_query(dbHandle, query);
            new rows = cache_num_rows();

            if(!rows)
            {
                SendClientMessage(playerid, COLOR_RED, !" Игрок не найден!");
                cache_delete(result);

                return Dialog_Show(playerid, Dialog:dPromocode);
            }
            else
            {
                strins(PlayerInfo[playerid][pReferal], inputtext, 0);
                return RegisterPlayer(playerid);
            }
        }
    }

    return true;
}

DialogCreate:dSex(playerid)
{
    Dialog_Open(playerid, Dialog:dSex, DIALOG_STYLE_MSGBOX,
                ">> Регистрация | {FFD500} Ukraine Project!",
                "{FFFFFF} Выберите свой пол, которым являетесь в реальности",
                "Мужской", "Женский");
}

DialogResponse:dSex(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        PlayerInfo[playerid][pSex] = PLAYER_SEX_WOMEN;
        
    }
    else
    {
        PlayerInfo[playerid][pSex] = PLAYER_SEX_MAN;
    }

    return Dialog_Show(playerid, Dialog:dSelectSkin);
}

DialogCreate:dSelectSkin(playerid)
{
    if(PlayerInfo[playerid][pSex] == PLAYER_SEX_MAN)
    {
        Dialog_Open(playerid, Dialog:dSelectSkin, DIALOG_STYLE_LIST,
            ">> Регистрация | {FFD500} Ukraine Project!",
            "{FFFFFF}Мужской светлокожий.\nМужской темнокожий.",
            "Далее", "Отмена");
    }
    else
    {
        Dialog_Open(playerid, Dialog:dSelectSkin, DIALOG_STYLE_LIST,
            ">> Регистрация | {FFD500} Ukraine Project!",
            "{FFFFFF}Женский светлокожий.\nЖенский темнокожий.",
            "Далее", "Отмена");
    }
}

DialogResponse:dSelectSkin(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        return Dialog_Show(playerid, Dialog:dSelectSkin);
    }

    if(PlayerInfo[playerid][pSex] == PLAYER_SEX_MAN)
    {
        if(!listitem)
        {
            new RandomWhiteSkins[] = {60, 101, 170, 180, 184, 250};
            #pragma unused RandomWhiteSkins

            PlayerInfo[playerid][pSkin] = RandomWhiteSkins[random(sizeof(RandomWhiteSkins))];

            return Dialog_Show(playerid, Dialog:dPromocode);
        }

        new RandomBlackSkins[] = {6, 7, 21, 22, 25};
        #pragma unused RandomBlackSkins

        PlayerInfo[playerid][pSkin] = RandomBlackSkins[random(sizeof(RandomBlackSkins))];

        return Dialog_Show(playerid, Dialog:dPromocode);
    }
    else
    {
        if(!listitem)
        {
            new RandomWhiteSkins[] = {77, 90};
            #pragma unused RandomWhiteSkins

            PlayerInfo[playerid][pSkin] = RandomWhiteSkins[random(sizeof(RandomWhiteSkins))];

            return Dialog_Show(playerid, Dialog:dPromocode);
        }

        new RandomBlackSkins[] = {65, 56};
        #pragma unused RandomBlackSkins

        PlayerInfo[playerid][pSkin] = RandomBlackSkins[random(sizeof(RandomBlackSkins))];

        return Dialog_Show(playerid, Dialog:dPromocode);
    }
}

DialogCreate:dLogin(playerid)
{
    Dialog_Open(playerid, Dialog:dLogin, DIALOG_STYLE_INPUT,
                "{FFFFFF} >> Авторизация | {FFD500} Ukraine Project!",
                "{FFFFFF} Добро пожаловать на игровой проект {FFD500} Ukraine Project!\n\
{FFFFFF} Чтобы продолжить, вам необходимо ввести пароль.\n\
{FFFFFF} Если вы забыли пароль, можете сбросить нажав кнопку \"Сброс\".",
                "Далее", "Сброс");
}
 
DialogResponse:dLogin(playerid, response, listitem, inputtext[])
{
    if (!response) {
        Dialog_Show(playerid, Dialog:dRestorePassword);
        return 1;
    }
 
    bcrypt_check(inputtext, PlayerInfo[playerid][pPassword], "OnPasswordChecked", "d", playerid);
    return 1;
}

DialogCreate:dRestorePassword(playerid)
{
    Dialog_Open(
        playerid,
        Dialog:dRestorePassword,
        DIALOG_STYLE_MSGBOX,
        "{FFFFFF} >> Сброс пароля | {FFD500} Ukraine Project!",
        "{FFFFFF} Сбросить пароль при помощи E-mail",
        "Далее",
        "Назад"
    );
}

DialogResponse:dRestorePassword(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        return Dialog_Show(playerid, Dialog:dLogin);
    }

    return Dialog_Show(playerid, Dialog:dResetPassword_StateMail);
}

DialogCreate:dResetPassword_StateMail(playerid)
{
    return Dialog_Open(
        playerid,
        Dialog:dResetPassword_StateMail,
        DIALOG_STYLE_INPUT,
        "{FFFFFF} >> Сброс пароля | {FFD500} Ukraine Project!",
        "{FFFFFF} Вам необходимо ввести E-mail от аккаунта, который вводили при регистрации",

        "Далее",
        "Назад"
    );
}

DialogResponse:dResetPassword_StateMail(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        return Dialog_Show(playerid, Dialog:dResetPassword_StateMail);
    }
    
    if (strlen(inputtext) < 10 || strlen(inputtext) > MAX_PLAYER_EMAIL)
    {
        SendClientMessage(playerid, -1, "{d30000} Неправильно введена почта! Повторите попытку.");
        return Dialog_Show(playerid, Dialog:dResetPassword_StateMail);
    }

    if(!IsValidEmail(inputtext)) 
    {
        SendClientMessage(playerid, -1, "{d30000} Неправильно введена почта! Повторите попытку.");
        return Dialog_Show(playerid, Dialog:dResetPassword_StateMail);
    }

    for(new i = 0, j = strlen(inputtext); i <= j && inputtext[i] != EOS; i++)
    {
        switch(inputtext[i])
        {
            case 'а'..'я', 'А'..'Я':
            {
                return Dialog_Show(playerid, Dialog:dResetPassword_StateMail); 
            }
            default:
            {
                break;
            }
        }
    }

    new query[100 + MAX_PLAYER_EMAIL];

    mysql_format(dbHandle, query, sizeof(query), "SELECT * FROM `accounts` WHERE `uMail` = '%s' LIMIT 1;", inputtext);
    new Cache:result = mysql_query(dbHandle, query);

    new rows = cache_num_rows();

    if(!rows)
    {
        SendClientMessage(playerid, -1, "{FFFFFF} Почта указана неправильно!");
        cache_delete(result);

        return Dialog_Show(playerid, Dialog:dResetPassword_StateMail);
    }
    else
    {
        SetPVarInt(playerid, #MAIL_CODE, MINIMAL_CODE_VALUE + random(MAXIMUM_CODE_VALUE));
        new string[32];
        format(string, sizeof(string), "Ваш код авторизации: %i", GetPVarInt(playerid, #MAIL_CODE));

        new arguments[144];
        format(arguments, sizeof(arguments), "to_mail=%s&subject=%s&messagee=%s", inputtext, "Авторизация", string);
        HTTP(playerid, HTTP_POST, "localhost/mailer.php", arguments, "MyHttpResponse");

        cache_delete(result);
        return Dialog_Show(playerid, Dialog:dSendMailCode);
    }
}

DialogCreate:dSendMailCode(playerid)
{
    return Dialog_Open(
        playerid,
        Dialog:dSendMailCode,
        DIALOG_STYLE_INPUT,
        "{FFFFFF} >> Сброс пароля | {FFD500} Ukraine Project!",
        "\
            {FFFFFF} Вам на почту E-mail, был отправлен код.\n\
            {FFFFFF} Введите его ниже в текстовое поле.\n\
            {FFFFFF} Если код не пришел, обратитесь в тех.поддержку проекта. *ссылка*",
        "Далее",
        "Назад"
    );
}

DialogResponse:dSendMailCode(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        return Dialog_Show(playerid, Dialog:dResetPassword_StateMail);
    }

    if(strval(inputtext) == GetPVarInt(playerid, #MAIL_CODE))
    {
        return Dialog_Show(playerid, Dialog:dResetPassword);
    }

    else
    {
        SendClientMessage(playerid, -1, "{FFFFFF} Код неверный!");
        return Dialog_Show(playerid, Dialog:dInputWrongCode);
    }
}

DialogCreate:dInputWrongCode(playerid)
{
    return Dialog_Open(
        playerid,
        Dialog:dInputWrongCode,
        DIALOG_STYLE_INPUT,
        ">> Авторизация | {FFD500} Ukraine Project!",
        "{FFFFFF} Нам нужно убедиться, что вы не мошенник и не пытаетесь украсть аккаунт.\n\
        {FFFFFF} Вам на эл.почту был отправлен код, который нужно ввести ниже.",

        "Далее",
        ""
    );
}

DialogCreate:dWrongPassword(playerid)
{
    static const fmt_string[] = "{FFFFFF} Нам нужно убедиться, что вы не мошенник и не пытаетесь украсть аккаунт.\n\
        {FFFFFF} Вам на эл.почту был отправлен код, который нужно ввести ниже.\n\
        {FFFFFF} Неправильный код! Попыток осталось - %i.";
    
    new string[sizeof fmt_string + 5];

    switch(GetPVarInt(playerid, #PLAYER_WRONG_ATTEMP))
    {
        case 0: format(string, sizeof(string), fmt_string, 2);
        case 1: format(string, sizeof(string), fmt_string, 1);
    }

    return Dialog_Open(
        playerid,
        Dialog:dWrongPassword,
        DIALOG_STYLE_INPUT,
        ">> Авторизация | {FFD500} Ukraine Project!",
        string,
        
        "Продолжить",
        ""
    );
}

DialogResponse:dInputWrongCode(playerid, response, listittem, inputtext[])
{
    if(strval(inputtext) != GetPVarInt(playerid, #MAIL_CODE))
    {
        switch(GetPVarInt(playerid, #PLAYER_WRONG_ATTEMP))
        {
            case 0:
            {
                SetPVarInt(playerid, #PLAYER_WRONG_ATTEMP, 1);
                return Dialog_Show(playerid, Dialog:dWrongPassword);
            }
            case 1:
            {
                SetPVarInt(playerid, #PLAYER_WRONG_ATTEMP, 2);
                return Dialog_Show(playerid, Dialog:dWrongPassword);
            }
            case 2: return Dialog_Show(playerid, Dialog:dWrongPassword);
        }
    }

    return true;
}

DialogResponse:dWrongPassword(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        SendClientMessage(playerid, -1, "{FFFFFF} Неправильный код! Перезайдите на сервер!");
        return KickEx(playerid);
    }

    if(strval(inputtext) != GetPVarInt(playerid, #MAIL_CODE))
    {
        SendClientMessage(playerid, -1, "{FFFFFF} Неправильный код! Перезайдите на сервер!");
        return KickEx(playerid);
    }
    else
    {
        return Dialog_Show(playerid, Dialog:dSendMailCode);
    }
}

DialogCreate:dResetPassword(playerid)
{
    return Dialog_Open(
        playerid,
        Dialog:dResetPassword,
        DIALOG_STYLE_INPUT,
        "{FFFFFF} >> Новый пароль | {FFD500} Ukraine Project!",
        "{FFFFFF} Введите новый пароль и запишите его обязательно!",

        "Далее",
        "Назад"
    );
}

DialogResponse:dResetPassword(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        return Dialog_Show(playerid, Dialog:dSendMailCode);
    }

    if (strlen(inputtext) < 6 || strlen(inputtext) > 12)
    {
        return Dialog_Show(playerid, Dialog:dResetPassword); 
    }

    for(new i = 0, j = strlen(inputtext); i <= j && inputtext[i] != EOS; i++)
    {
        switch(inputtext[i])
        {
            case 'а'..'я', 'А'..'Я', '@', '!', '/':
            {
                SendClientMessage(playerid, COLOR_RED, !"{d30000} Пароль не может состоять из символов! Повторите попытку.");
                return Dialog_Show(playerid, Dialog:dResetPassword); 
            }
            default:
            {
                return bcrypt_hash(inputtext, BCRYPT_COST, "OnPasswordHashed", "d", playerid);
            }
        }
    }

    return true;
}