using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PatrollingAI : BasicAI
{
    // Радиус территории обхода
    [SerializeField] private float patrollingRadius;
    // Радиус зоны обнаружения
    [SerializeField] private float triggerRadius;
    // Время подготовки
    [SerializeField] private float waitingTime = 5.0f;
    // Радиус зоны перехода к атаке
    [SerializeField] private float attackRadius;
    // Радиус зоны коллизии с предметами
    [SerializeField] private float obstacleRange = 5.0f;
    // Радиус зоны коллизии с игроком
    [SerializeField] private float attackRange = 1.0f;
    // Начальная скорость патрулирования
    [SerializeField] private float baseSpeed = 5.0f;
    // Скорость преследования
    [SerializeField] private float walkingSpeed = 7.0f;
    // Скорость атаки
    [SerializeField] private float pursuitSpeed = 10.0f;
    // Урон
    [SerializeField] private float damage;
    // Скорость перемещения
    public float speed = 3.0f;
    // Начальные позиции
    private float startXPosition, startYPosition;
    // Состояние: возможные значения: "PATROL", "WAITING", "WALKING", "PURSUIT", "ATTACK"
    private string state = "PATROL";
    // Таймер перехода к фазе обнаружения из фазы подготовки
    private float timer = 0;
    //

    // Объект преследования
    /*
        * Возможна смена типа с GameObject на кастомный скрипт для учета приседа *
    */
    private GameObject hitObject;



    void Start()
    {
        startXPosition = transform.position.x;
        startYPosition = transform.position.y;
        speed = baseSpeed;
        timer = waitingTime;
    }


    void Update()
    {
        switch (state) {
            case "PATROL":
                Patrol();
                break;
            case "WAITING":
                Waiting();
                break;
            case "WALKING":
                Walking();
                break;
            case "PURSUIT":
                Pursuit();
                break;
        }

    }

    // Патрулирование
    void Patrol() {
            transform.Translate(0, 0, speed * Time.deltaTime);

            Ray ray = new Ray(transform.position, transform.forward);
            RaycastHit hit;
            if (Physics.SphereCast(ray, patrollingRadius, out hit))
            {
                GameObject hitObj = hit.transform.gameObject;
                if (hitObj.GetComponent<PlayerCharacter>()) {
                    hitObject = hitObj;
                    state = "WAITING";
                    timer = waitingTime;
                }
                else if (hit.distance < obstacleRange) {
                    float angle = Random.Range(-110, 110);
                    transform.Rotate(0, angle, 0);
                }
            }
    }

    bool isInSphere(float radius) {
        return (Vector3.Distance(transform.position, hitObject.transform.position) <= radius);
    }

    // Подготовка
    void Waiting() {
        if (isInSphere(triggerRadius)) {
            timer -= Time.deltaTime;
            if (timer <= 0) {
                state = "WALKING";
                speed = walkingSpeed;
            }
        } else {
            state = "PATROL";
             timer = waitingTime;
             speed = baseSpeed;
        }
    }

    void Walking() {
        if (isInSphere(triggerRadius)) {
            transform.Position = Vector3.MoveTowards(transform.position, hitObject.transform.position, speed * Time.deltaTime);
            if(isInSphere(attackRadius)) {
                state = "PURSUIT"
                speed = pursuitSpeed;
            }
        } else {
            state = "PATROL";
             timer = waitingTime;
             speed = baseSpeed;
        }
    }

    // Преследование перед атакой
    void Pursuit() {
        if (isInSphere(attackRadius)) {
            transform.Position = Vector3.MoveTowards(transform.position, hitObject.transform.position, speed * Time.deltaTime);
            if(isInSphere(attackRange)) {
                state = "ATTACK";
                Attack();
            }
        } else {
            state = "PURSUIT";
             speed = walkingSpeed;
        }
    }

    // Атака
    void Attack() {

    }


   
}
